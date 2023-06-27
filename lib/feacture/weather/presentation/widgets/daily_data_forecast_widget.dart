import 'package:app_clima/core/constants/constants.dart';
import 'package:app_clima/feacture/weather/domain/entities/weather_data_darly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DailyDataForecast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DailyDataForecast({super.key, required this.weatherDataDaily});

  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    String textTime = DateFormat.EEEE('es').format(time);
    String x = textTime[0].toUpperCase() + textTime.substring(1);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400.h,
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: AppColors.colorContainer,
          borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Pronostico 7 dias',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 17.sp),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 300.h,
      child: ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: weatherDataDaily.daily.length > 7
            ? 7
            : weatherDataDaily.daily.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 60.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 80.w,
                      child: Text(
                        getDay(weatherDataDaily.daily[index].dt),
                        style: TextStyle(
                            color: AppColors.textPrimary, fontSize: 15.sp),
                      ),
                    ),
                    Image.asset(
                        "assets/weather/${weatherDataDaily.daily[index].weather.first.icon}.png"),
                    Text(
                        "${weatherDataDaily.daily[index].temp.max}°/${weatherDataDaily.daily[index].temp.min}°",
                        style: TextStyle(
                            color: AppColors.textPrimary, fontSize: 15.sp))
                  ],
                ),
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }
}
