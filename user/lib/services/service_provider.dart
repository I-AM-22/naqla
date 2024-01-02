import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:user/features/app/presentation/bloc/app_bloc.dart';
import 'package:user/features/home/presentation/bloc/home_bloc.dart';

class ServiceProvider extends StatelessWidget {
  const ServiceProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<AppCubit>()),
        BlocProvider(create: (_) => GetIt.I<HomeBloc>())
      ],
      child: child,
    );
  }
}
