// To parse this JSON data, do
//
//     final weatherDataHourlyModel = weatherDataHourlyModelFromJson(jsonString);

import 'package:app_clima/feacture/weather/domain/entities/weather_data_hourly.dart';

class WeatherDataHourlyModel extends WeatherDataHourly {
  final List<HourlyModel> hourlyModel;

  WeatherDataHourlyModel({
    required this.hourlyModel,
  }) : super(hourly: hourlyModel);

  factory WeatherDataHourlyModel.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourlyModel(
        hourlyModel: List<HourlyModel>.from(
            json["hourly"].map((x) => HourlyModel.fromJson(x))),
      );
}

class HourlyModel extends Hourly {
  final int? dt;
  final int temp;
  final List<Weather> weather;

  HourlyModel({
    this.dt,
    required this.temp,
    required this.weather,
  }) : super(temp: temp, weather: weather);

  factory HourlyModel.fromJson(Map<String, dynamic> json) => HourlyModel(
        dt: json["dt"],
        temp: json["temp"]?.round(),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}
