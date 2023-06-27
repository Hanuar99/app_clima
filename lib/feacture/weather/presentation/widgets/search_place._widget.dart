import 'package:app_clima/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPlaceWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final VoidCallback onSearchPressed;
  final String place;

  const SearchPlaceWidget({
    Key? key,
    required this.textEditingController,
    required this.onSearchPressed,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: AppColors.background,
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: AppColors.iconsPrimary,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: textEditingController,
              style: TextStyle(color: AppColors.textPrimary),
              decoration: InputDecoration(
                hintText: place,
                border: InputBorder.none,
                hintStyle: TextStyle(color: AppColors.textPrimary),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: AppColors.iconsPrimary,
            ),
            onPressed: onSearchPressed,
          ),
        ],
      ),
    );
  }
}
