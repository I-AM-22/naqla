
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/state_managment/state/common_state.dart';
import '../../../domain/use_case/get_use_case.dart';



part '{{feature_name.snakeCase()}}_event.dart';

part '{{feature_name.snakeCase()}}_state.dart';

@injectable
class {{feature_name.pascalCase()}}Bloc extends Bloc<{{feature_name.pascalCase()}}Event, Map<int,CommonState>> {
final {{feature_name.pascalCase()}}UseCae useCae;
{{feature_name.pascalCase()}}Bloc(this.useCae) : super({{feature_name.pascalCase()}}State.initState) {
on<{{feature_name.pascalCase()}}Event>((event, emit) {

}) ;
}
}
