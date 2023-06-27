import 'package:app_clima/feacture/weather/domain/entities/weather.dart';
import 'package:equatable/equatable.dart';

class WeatherDataCurrent {
  final Current current;

  WeatherDataCurrent({
    required this.current,
  });
}

class Current extends Equatable {
  final int? temp;
  final List<Weather> weather;

  const Current({
    required this.temp,
    required this.weather,
  });

  @override
  List<Object?> get props => [
        temp,
        weather,
      ];
}
