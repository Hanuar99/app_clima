import 'package:app_clima/core/constants/constants.dart';
import 'package:app_clima/feacture/weather/presentation/bloc/clima_bloc.dart';
import 'package:app_clima/feacture/weather/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GpsAccessPage extends StatelessWidget {
  const GpsAccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                tileMode: TileMode.clamp,
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [AppColors.background, AppColors.background2])),
        child: Center(
          child: BlocBuilder<ClimaBloc, ClimaState>(
            builder: (context, state) {
              return state.isServiceGpsEnabled
                  ? const _AccessButon()
                  : const _EnableGpsMessage();
            },
          ),
        ),
      ),
    );
  }
}

class _AccessButon extends StatelessWidget {
  const _AccessButon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: AppColors.colorContainer),
        ],
      ),
      width: ScreenUtil().screenWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 22.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                Icons.my_location,
                size: 25.h,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
                'La App Clima quiere acceder a tu ubicacion, Para continuar acepta los permisos. ',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 19.sp,
                  color: AppColors.textPrimary,
                )),
            SizedBox(height: 16.h),
            SizedBox(
              height: 25,
              child: CustomButton(
                text: 'Solicitar Acceso',
                colorButton: AppColors.primaryColor,
                onPressed: () async {
                  final gpsBloc = BlocProvider.of<ClimaBloc>(context);

                  await gpsBloc.askGpsAccess();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 301.w,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: AppColors.colorContainer),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.near_me,
                size: 25.h,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 10.h),
              Text(
                  'Parece que tu GPS esta desactivado, Para continuar, activa el GPS!',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 19.sp,
                    color: AppColors.textPrimary,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
