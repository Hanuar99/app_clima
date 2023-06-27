import 'package:app_clima/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color colorButton;
  final String text;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.colorButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40.h,
      decoration: BoxDecoration(
        color: colorButton,
        borderRadius: BorderRadius.circular(86.r),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(20.0),
        ),
        child: Text(text,
            style: TextStyle(
              fontSize: 19.sp,
              color: AppColors.textSecondary,
            )),
      ),
    );
  }
}
