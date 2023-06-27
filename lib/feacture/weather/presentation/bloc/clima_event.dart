part of 'clima_bloc.dart';

abstract class ClimaEvent extends Equatable {
  const ClimaEvent();

  @override
  List<Object> get props => [];
}

class GetMyLocation extends ClimaEvent {}

class GpsAndPermissionEvent extends ClimaEvent {
  final bool isServiceGpsEnabled;
  final bool isPermissionGpsEnabled;

  const GpsAndPermissionEvent({
    required this.isServiceGpsEnabled,
    required this.isPermissionGpsEnabled,
  });
}

class GetDataWeatherEvent extends ClimaEvent {
  final double lat;
  final double lon;

  GetDataWeatherEvent({required this.lat, required this.lon});
}
