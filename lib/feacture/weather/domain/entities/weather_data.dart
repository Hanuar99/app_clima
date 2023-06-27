import 'package:app_clima/feacture/weather/domain/entities/weather_data_current.dart';
import 'package:app_clima/feacture/weather/domain/entities/weather_data_darly.dart';
import 'package:app_clima/feacture/weather/domain/entities/weather_data_hourly.dart';

class WeatherData {
  final WeatherDataCurrent? weatherDataCurrent;
  final WeatherDataHourly? weatherDataHourly;
  final WeatherDataDaily? weatherDataDaily;

  WeatherData({
    required this.weatherDataCurrent,
    required this.weatherDataHourly,
    required this.weatherDataDaily,
  });
}
