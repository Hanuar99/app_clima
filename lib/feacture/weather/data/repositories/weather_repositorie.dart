import 'package:app_clima/core/error/exceptions.dart';
import 'package:app_clima/core/network/network_info.dart';
import 'package:app_clima/feacture/weather/data/datasources/remote/openWeather_api.dart';
import 'package:app_clima/feacture/weather/domain/entities/weather_data.dart';
import 'package:dartz/dartz.dart';

import '../../domain/contracts/weather_contracts.dart';

class WeatherRepository implements WeatherContracts {
  final OpenWeatherApiContract openWeatherApiContract;
  final NetworkInfo networkInfo;

  WeatherRepository({
    required this.networkInfo,
    required this.openWeatherApiContract,
  });

  @override
  Future<Either<GenericException, WeatherData>> getDataWeather(
      {required double lat, required double lon}) async {
    if (await networkInfo.isConnected) {
      try {
        WeatherData weatherData =
            await openWeatherApiContract.getDataWeather(lat: lat, lon: lon);
        return Right(weatherData);
      } catch (_) {
        return Left(GetDataApiException('Error al obtener datos'));
      }
    } else {
      return left(NoInternetConnectionException('Sin conexion a internet'));
    }
  }
}
