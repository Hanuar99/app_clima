import 'package:app_clima/feacture/weather/presentation/bloc/clima_bloc.dart';
import 'package:app_clima/feacture/weather/presentation/pages/home_page.dart';
import 'package:app_clima/feacture/weather/presentation/widgets/permisos/gps_access_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadingCheckGpsPage extends StatefulWidget {
  const LoadingCheckGpsPage({super.key});

  @override
  State<LoadingCheckGpsPage> createState() => _LoadingCheckGpsPageState();
}

class _LoadingCheckGpsPageState extends State<LoadingCheckGpsPage> {
  @override
  void initState() {
    BlocProvider.of<ClimaBloc>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClimaBloc, ClimaState>(
      builder: (context, state) {
        if (!state.isGpsAllGranted) {
          return const GpsAccessPage();
        }

        return const HomePage();
      },
    );
  }
}
