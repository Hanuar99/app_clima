import 'package:app_clima/feacture/weather/data/models/weather_data_hourly_model.dart';

class WeatherDataDaily {
  final List<Daily> daily;

  WeatherDataDaily({
    required this.daily,
  });
}

class Daily {
  final int dt;
  final Temp temp;
  final List<Weather> weather;
  final int clouds;

  Daily({
    required this.dt,
    required this.temp,
    required this.weather,
    required this.clouds,
  });
}

class Temp {
  final double day;
  final int min;
  final int max;
  final double night;
  final double eve;
  final double morn;

  Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });
}
