import 'package:app_clima/core/error/exceptions.dart';
import 'package:app_clima/feacture/weather/domain/contracts/weather_contracts.dart';
import 'package:dartz/dartz.dart';

import '../entities/weather_data.dart';

class GetDataWeather {
  final WeatherContracts weatherContracts;

  GetDataWeather(this.weatherContracts);

  Future<Either<GenericException, WeatherData>> call(
      {required double lat, required double lon}) {
    return weatherContracts.getDataWeather(lat: lat, lon: lon);
  }
}
