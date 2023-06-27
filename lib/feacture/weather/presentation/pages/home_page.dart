import 'package:app_clima/core/constants/constants.dart';
import 'package:app_clima/feacture/weather/presentation/widgets/current_weather_widget.dart';
import 'package:app_clima/feacture/weather/presentation/widgets/custom_button.dart';
import 'package:app_clima/feacture/weather/presentation/widgets/daily_data_forecast_widget.dart';
import 'package:app_clima/feacture/weather/presentation/widgets/header_widget.dart';
import 'package:app_clima/feacture/weather/presentation/widgets/hourly_data_widget.dart';
import 'package:app_clima/feacture/weather/presentation/widgets/search_place._widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

import '../bloc/clima_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  Future<void> _onSearchPressed() async {
    String place = _searchController.text;
    final lugar = await locationFromAddress(place);
    BlocProvider.of<ClimaBloc>(context).add(GetDataWeatherEvent(
        lat: lugar.first.latitude, lon: lugar.first.longitude));
  }

  String city = '';
  String cityInfo = '';
  getAddress(lat, lon) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placeMark[0];
    setState(() {
      city = place.locality!;
      cityInfo = place.locality! + ', ' + place.country!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ClimaBloc, ClimaState>(
          listener: (context, state) {
            if (state.getDataWeatherStatus ==
                GetDataWeatherStatus.loadSuccess) {
              getAddress(state.latLocation, state.lonLocation);
            }
          },
          builder: (context, state) {
            if (state.getMyLocationStatus == GetDataWeatherStatus.loading ||
                state.getDataWeatherStatus == GetDataWeatherStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.iconLoading,
                ),
              );
            } else if (state.getDataWeatherStatus ==
                GetDataWeatherStatus.loadSuccess) {
              return SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          tileMode: TileMode.clamp,
                          begin: Alignment.topRight,
                          end: Alignment.bottomRight,
                          colors: [
                        AppColors.background,
                        AppColors.background2
                      ])),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchPlaceWidget(
                          place: cityInfo,
                          textEditingController: _searchController,
                          onSearchPressed: _onSearchPressed),
                      Center(
                          child: HeaderWidget(
                        city: city,
                      )),
                      SizedBox(height: 30.h),
                      CurrentWeather(
                          weatherDataCurrent:
                              state.weatherData!.weatherDataCurrent!),
                      HourlyDataWeather(
                          weatherDataHourly:
                              state.weatherData!.weatherDataHourly!),
                      DailyDataForecast(
                          weatherDataDaily:
                              state.weatherData!.weatherDataDaily!)
                    ],
                  ),
                ),
              );
            } else if (state.getDataWeatherStatus ==
                GetDataWeatherStatus.error) {
              return Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning,
                        color: AppColors.error,
                        size: 30.h,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        state.errorMessage,
                        style: TextStyle(
                            color: AppColors.textPrimary, fontSize: 20.sp),
                      ),
                      SizedBox(height: 10.h),
                      CustomButton(
                          onPressed: () {
                            BlocProvider.of<ClimaBloc>(context).add(
                                GetDataWeatherEvent(
                                    lat: state.latLocation,
                                    lon: state.lonLocation));
                          },
                          text: 'Reintentar',
                          colorButton: AppColors.error)
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
