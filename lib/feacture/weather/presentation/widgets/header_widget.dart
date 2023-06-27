import 'package:app_clima/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatelessWidget {
  final String city;
  HeaderWidget({super.key, required this.city});

  String date = DateFormat.yMMMMd('es').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50.h),
        Text(
          city,
          style: TextStyle(fontSize: 35.sp, color: AppColors.textPrimary),
        ),
        Text(
          date,
          style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
