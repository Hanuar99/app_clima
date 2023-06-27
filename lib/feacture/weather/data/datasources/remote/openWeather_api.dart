import 'dart:convert';

import 'package:app_clima/feacture/weather/data/models/weather_data_current_model.dart';
import 'package:app_clima/feacture/weather/data/models/weather_data_daily_model.dart';
import 'package:app_clima/feacture/weather/data/models/weather_data_hourly_model.dart';
import 'package:app_clima/feacture/weather/domain/entities/weather_data.dart';
import 'package:http/http.dart' as http;

abstract class OpenWeatherApiContract {
  Future<WeatherData> getDataWeather(
      {required double lat, required double lon});
}

class OpenWeatherApiImpl implements OpenWeatherApiContract {
  final http.Client client;

  static const String apikey = "ae294f666c9a141ef6c3e9e7877906e1";

  OpenWeatherApiImpl({required this.client});

  @override
  Future<WeatherData> getDataWeather(
      {required double lat, required double lon}) async {
    final uri = Uri.parse(
        'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely&units=metric&appid=$apikey');
    var response = await client.get(uri);
    var jsonString = jsonDecode(response.body);

    return WeatherData(
        weatherDataCurrent: WeatherDataCurrentModel.fromJson(jsonString),
        weatherDataHourly: WeatherDataHourlyModel.fromJson(jsonString),
        weatherDataDaily: WeatherDataDailyModel.fromJson(jsonString));
  }
}
