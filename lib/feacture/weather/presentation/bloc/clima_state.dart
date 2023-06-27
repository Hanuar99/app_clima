part of 'clima_bloc.dart';

enum GetDataWeatherStatus { idle, loading, loadSuccess, error }

enum GetMyLocationStatus { idle, loading, loadSuccess }

class ClimaState extends Equatable {
  final GetDataWeatherStatus getDataWeatherStatus;
  final GetMyLocationStatus getMyLocationStatus;
  final double latLocation;
  final double lonLocation;
  final bool isServiceGpsEnabled;
  final bool isPermissionGpsEnabled;
  final WeatherData? weatherData;
  final String errorMessage;

  bool get isGpsAllGranted => isServiceGpsEnabled && isPermissionGpsEnabled;

  const ClimaState({
    this.getDataWeatherStatus = GetDataWeatherStatus.idle,
    this.getMyLocationStatus = GetMyLocationStatus.idle,
    this.latLocation = 0.0,
    this.lonLocation = 0.0,
    this.isServiceGpsEnabled = false,
    this.isPermissionGpsEnabled = false,
    this.weatherData,
    this.errorMessage = '',
  });

  ClimaState copyWith({
    GetDataWeatherStatus? getDataWeatherStatus,
    GetMyLocationStatus? getMyLocationStatus,
    double? latLocation,
    double? lonLocation,
    String? errorMessage,
    bool? isServiceGpsEnabled,
    bool? isPermissionGpsEnabled,
    WeatherData? weatherData,
  }) {
    return ClimaState(
      getDataWeatherStatus: getDataWeatherStatus ?? this.getDataWeatherStatus,
      getMyLocationStatus: getMyLocationStatus ?? this.getMyLocationStatus,
      latLocation: latLocation ?? this.latLocation,
      lonLocation: lonLocation ?? this.lonLocation,
      isServiceGpsEnabled: isServiceGpsEnabled ?? this.isServiceGpsEnabled,
      isPermissionGpsEnabled:
          isPermissionGpsEnabled ?? this.isPermissionGpsEnabled,
      weatherData: weatherData ?? this.weatherData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        getDataWeatherStatus,
        getMyLocationStatus,
        latLocation,
        lonLocation,
        isServiceGpsEnabled,
        isPermissionGpsEnabled,
        weatherData,
        errorMessage,
      ];
}
