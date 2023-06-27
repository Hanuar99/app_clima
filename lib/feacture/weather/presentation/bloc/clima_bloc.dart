import 'dart:async';

import 'package:app_clima/feacture/weather/domain/entities/weather_data.dart';
import 'package:app_clima/feacture/weather/domain/usecases/get_data_weather.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'clima_event.dart';
part 'clima_state.dart';

class ClimaBloc extends Bloc<ClimaEvent, ClimaState> {
  final GetDataWeather getDataWeather;
  StreamSubscription? _gpsServiceSubscription;
  ClimaBloc({
    required this.getDataWeather,
  }) : super(const ClimaState()) {
    on<GpsAndPermissionEvent>(_gpsAndPermission);
    on<GetMyLocation>(_getMyLocation);
    on<GetDataWeatherEvent>(_getDataWeatherEvent);
  }

  Future<void> init() async {
    final gpsInitStatus = await Future.wait({
      _checkGpsStatus(),
      _checkPermission(),
    });

    add(GpsAndPermissionEvent(
        isServiceGpsEnabled: gpsInitStatus[0],
        isPermissionGpsEnabled: gpsInitStatus[1]));
  }

  Future<bool> _checkPermission() async {
    bool isGranted = false;
    final check = await Geolocator.checkPermission();
    if (check == LocationPermission.whileInUse) {
      isGranted = true;
    }
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();

    _gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = (event.index == 1) ? true : false;
      add(GpsAndPermissionEvent(
        isServiceGpsEnabled: isEnabled,
        isPermissionGpsEnabled: state.isPermissionGpsEnabled,
      ));
    });
    return isEnabled;
  }

  Future<void> askGpsAccess() async {
    final status = await Geolocator.requestPermission();

    switch (status) {
      case LocationPermission.always:
        add(GpsAndPermissionEvent(
            isServiceGpsEnabled: state.isServiceGpsEnabled,
            isPermissionGpsEnabled: true));
        add(GetMyLocation());
        break;
      case LocationPermission.denied:
        add(GpsAndPermissionEvent(
            isServiceGpsEnabled: state.isServiceGpsEnabled,
            isPermissionGpsEnabled: false));
        break;
      case LocationPermission.deniedForever:
        add(GpsAndPermissionEvent(
            isServiceGpsEnabled: state.isServiceGpsEnabled,
            isPermissionGpsEnabled: false));
        break;
      case LocationPermission.whileInUse:
        add(GpsAndPermissionEvent(
            isServiceGpsEnabled: state.isServiceGpsEnabled,
            isPermissionGpsEnabled: true));
        add(GetMyLocation());
        break;

      case LocationPermission.unableToDetermine:
        add(GpsAndPermissionEvent(
            isServiceGpsEnabled: state.isServiceGpsEnabled,
            isPermissionGpsEnabled: false));
        break;
    }
  }

  Future<void> _getMyLocation(
      GetMyLocation event, Emitter<ClimaState> emit) async {
    emit(state.copyWith(getMyLocationStatus: GetMyLocationStatus.loading));
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('position $position');
    emit(state.copyWith(
        latLocation: position.latitude,
        lonLocation: position.longitude,
        getMyLocationStatus: GetMyLocationStatus.loadSuccess));
    add(GetDataWeatherEvent(lat: position.latitude, lon: position.longitude));
  }

  Future<void> _gpsAndPermission(
      GpsAndPermissionEvent event, Emitter<ClimaState> emit) async {
    emit(state.copyWith(
      isServiceGpsEnabled: event.isServiceGpsEnabled,
      isPermissionGpsEnabled: event.isPermissionGpsEnabled,
    ));
    if (state.isGpsAllGranted) {
      add(GetMyLocation());
    }
  }

  Future<void> _getDataWeatherEvent(
      GetDataWeatherEvent event, Emitter<ClimaState> emit) async {
    emit(state.copyWith(getDataWeatherStatus: GetDataWeatherStatus.loading));
    final dataOrFailure = await getDataWeather(lat: event.lat, lon: event.lon);
    dataOrFailure.fold(
        (l) => emit(state.copyWith(
            getDataWeatherStatus: GetDataWeatherStatus.error,
            errorMessage: l.message)),
        (r) => emit(state.copyWith(
            weatherData: r,
            getDataWeatherStatus: GetDataWeatherStatus.loadSuccess,
            latLocation: event.lat,
            lonLocation: event.lon)));
    // emit(state.copyWith(getDataWeatherStatus: GetDataWeatherStatus.idle));
  }

  @override
  Future<void> close() {
    _gpsServiceSubscription?.cancel();
    return super.close();
  }
}
