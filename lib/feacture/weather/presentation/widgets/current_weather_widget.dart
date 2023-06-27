import 'package:app_clima/core/constants/constants.dart';
import 'package:app_clima/feacture/weather/domain/entities/weather_data_current.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrentWeather extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const CurrentWeather({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          temperaturaAreaWidget(),
          Text("${weatherDataCurrent.current.weather.first.description}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget temperaturaAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Transform.scale(
          scale: 1.3,
          child: Image.asset(
            "assets/weather/${weatherDataCurrent.current.weather[0].icon}.png",
          ),
        ),
        Container(
          height: 50.h,
          width: 1,
          color: AppColors.dividerLine,
        ),
        Text("${weatherDataCurrent.current.temp!.toInt()}°",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 68.sp,
                color: AppColors.textPrimary))
      ],
    );
  }
}
