import 'package:app_clima/core/network/network_info.dart';
import 'package:app_clima/feacture/weather/data/datasources/remote/openWeather_api.dart';
import 'package:app_clima/feacture/weather/data/repositories/weather_repositorie.dart';
import 'package:app_clima/feacture/weather/domain/usecases/get_data_weather.dart';
import 'package:app_clima/feacture/weather/presentation/bloc/clima_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'feacture/weather/domain/contracts/weather_contracts.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ClimaBloc(getDataWeather: sl()));
  // Use Cases

  sl.registerLazySingleton(() => GetDataWeather(sl()));

  // Contracts
  sl.registerLazySingleton<WeatherContracts>(() => WeatherRepository(
        networkInfo: sl(),
        openWeatherApiContract: sl(),
      ));

// Data sources remote
  sl.registerLazySingleton<OpenWeatherApiContract>(
      () => OpenWeatherApiImpl(client: sl()));

  // External

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
