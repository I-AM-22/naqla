import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:user/core/common/model/page_state/page_state.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';

import '../../../app/domain/repository/prefs_repository.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../location_map/presentation/pages/my_map.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Stack(
      children: [
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) {
            if (previous.polylineState != current.polylineState) {
              return true;
            }
            if (previous.currentDestination != current.currentDestination) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if (state.polylineState.isLoaded) {
              return (state.polylineState.whenOrNull(
                loaded: (polyline) {
                  return MyMap(
                    height: double.infinity,
                    destination: state.currentDestination,
                    polyLines: polyline,
                    origin: state.currentOrigin,
                    controller: state.mapController,
                    key: ValueKey(GetIt.I<PrefsRepository>().getTheme),
                  );
                },
              )!);
            } else {
              return MyMap(
                height: double.infinity,
                controller: state.mapController,
                key: ValueKey(GetIt.I<PrefsRepository>().getTheme),
              );
            }
          },
        ),
      ],
    ));
  }
}
