import 'package:app_clima/core/utils/weatherConditions.dart';
import 'package:app_clima/feacture/weather/domain/entities/weather_data_current.dart';

import '../../domain/entities/weather.dart';

class WeatherDataCurrentModel extends WeatherDataCurrent {
  final Current current;

  WeatherDataCurrentModel({
    required this.current,
  }) : super(current: current);

  factory WeatherDataCurrentModel.fromJson(Map<String, dynamic> json) =>
      WeatherDataCurrentModel(
        current: CurrentModel.fromJson(json["current"]),
      );
}

class CurrentModel extends Current {
  final int temp;
  final List<WeatherModel> weather;

  CurrentModel({
    required this.temp,
    required this.weather,
  }) : super(
          temp: temp,
          weather: weather,
        );

  factory CurrentModel.fromJson(Map<String, dynamic> json) => CurrentModel(
        temp: json["temp"].round(),
        weather: List<WeatherModel>.from(
          json["weather"].map((x) => WeatherModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
      };
}

class WeatherModel extends Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  }) : super(
          id: id,
          main: main,
          description: description,
          icon: icon,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json["id"],
      main: json["main"],
      description: weatherConditions[json["id"]]!,
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}
