import 'package:flutter/material.dart';
import 'package:naqla/core/common/model/localization_config.dart';
import 'package:naqla/features/app/presentation/pages/app.dart';
import 'package:naqla/generated/codegen_loader.g.dart';
import 'package:naqla/initialization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(() => const App(),
      localizationConfig:
          LocalizationConfig(assetLoader: const CodegenLoader()));
}
