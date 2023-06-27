import 'package:app_clima/feacture/weather/data/models/weather_data_hourly_model.dart';
import 'package:app_clima/feacture/weather/domain/entities/weather_data_darly.dart';

class WeatherDataDailyModel extends WeatherDataDaily {
  final List<DailyModel> dailyModel;

  WeatherDataDailyModel({
    required this.dailyModel,
  }) : super(daily: dailyModel);

  factory WeatherDataDailyModel.fromJson(Map<String, dynamic> json) =>
      WeatherDataDailyModel(
        dailyModel: List<DailyModel>.from(
            json["daily"].map((x) => DailyModel.fromJson(x))),
      );
}

class DailyModel extends Daily {
  final int dt;
  final TempModel temp;
  final List<Weather> weather;
  final int clouds;

  DailyModel({
    required this.dt,
    required this.temp,
    required this.weather,
    required this.clouds,
  }) : super(dt: dt, temp: temp, weather: weather, clouds: clouds);

  factory DailyModel.fromJson(Map<String, dynamic> json) => DailyModel(
        dt: json["dt"],
        temp: TempModel.fromJson(json["temp"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: json["clouds"],
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "temp": temp.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds,
      };
}

class TempModel extends Temp {
  final double day;
  final int min;
  final int max;
  final double night;
  final double eve;
  final double morn;

  TempModel({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  }) : super(day: day, min: min, max: max, night: night, eve: eve, morn: morn);

  factory TempModel.fromJson(Map<String, dynamic> json) => TempModel(
        day: json["day"]?.toDouble(),
        min: json["min"].round(),
        max: json["max"].round(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}
