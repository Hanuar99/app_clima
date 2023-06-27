import 'package:app_clima/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../entities/weather_data.dart';

abstract class WeatherContracts {
  Future<Either<GenericException, WeatherData>> getDataWeather(
      {required double lat, required double lon});
}
