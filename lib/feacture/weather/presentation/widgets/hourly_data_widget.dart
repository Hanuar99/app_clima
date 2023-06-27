import 'package:app_clima/core/constants/constants.dart';
import 'package:app_clima/feacture/weather/domain/entities/weather_data_hourly.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HourlyDataWeather extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  const HourlyDataWeather({super.key, required this.weatherDataHourly});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.h),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Hoy',
            style: TextStyle(fontSize: 18.sp, color: AppColors.textPrimary),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 150.h,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12
            ? 12
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100.w,
            margin: EdgeInsets.only(left: 20.w, right: 5),
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
                color: AppColors.colorContainer,
                borderRadius: BorderRadius.circular(20.r)),
            child: HourlyDetails(
                temp: weatherDataHourly.hourly[index].temp,
                timeStamp: weatherDataHourly.hourly[index].dt!,
                weatherIcon:
                    weatherDataHourly.hourly[index].weather.first.icon),
          );
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  final int temp;
  final int timeStamp;
  final String weatherIcon;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat.jm().format(time);
  }

  const HourlyDetails(
      {super.key,
      required this.temp,
      required this.timeStamp,
      required this.weatherIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(getTime(timeStamp),
            style: TextStyle(color: AppColors.textPrimary)),
        Image.asset("assets/weather/$weatherIcon.png"),
        Text('$temp°', style: TextStyle(color: AppColors.textPrimary)),
      ],
    );
  }
}
