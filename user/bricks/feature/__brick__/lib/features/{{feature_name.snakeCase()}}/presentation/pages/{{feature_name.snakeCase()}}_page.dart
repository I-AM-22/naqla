import 'package:flutter/material.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';


class {{feature_name.pascalCase()}}Page extends StatelessWidget {
static String get name => "{{feature_name.pascalCase()}}Page";
static String get path => "{{feature_name.pascalCase()}}Page";

const {{feature_name.pascalCase()}}Page({super.key});

@override
Widget build(BuildContext context) {
return AppScaffold(
body: Column(),
);

}

}
