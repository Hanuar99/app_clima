import 'package:app_clima/feacture/weather/data/models/weather_data_hourly_model.dart';

class WeatherDataHourly {
  final List<Hourly> hourly;

  WeatherDataHourly({
    required this.hourly,
  });
}

class Hourly {
  final int? dt;
  final int temp;
  final List<Weather> weather;

  Hourly({
    this.dt,
    required this.temp,
    required this.weather,
  });
}
