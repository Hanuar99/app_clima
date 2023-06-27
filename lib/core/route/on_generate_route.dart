import 'package:app_clima/feacture/weather/presentation/pages/loading_check_gps_page.dart';
import 'package:flutter/material.dart';

import 'page_const.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.homePage:
        {
          return routeBuilder(const LoadingCheckGpsPage());
        }

      default:
        {
          return routeBuilder(const NoPageFound());
        }
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not found'),
      ),
      body: const Center(
        child: Text('Page Not found'),
      ),
    );
  }
}
