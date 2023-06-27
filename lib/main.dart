import 'package:app_clima/core/route/on_generate_route.dart';
import 'package:app_clima/core/route/page_const.dart';
import 'package:app_clima/feacture/weather/presentation/bloc/clima_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dependency_injection.dart' as di;
import 'core/constants/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClimaBloc>(create: (_) => di.sl<ClimaBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'App Clima',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('es')],
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.background,
            ),
            onGenerateRoute: OnGenerateRoute.route,
            initialRoute: PageConst.homePage,
          );
        },
      ),
    );
  }
}
