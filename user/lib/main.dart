import 'package:flutter/material.dart';
import 'package:user/core/common/model/localization_config.dart';
import 'package:user/features/app/presentation/pages/app.dart';
import 'package:user/generated/codegen_loader.g.dart';
import 'package:user/initialization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(() => const App(),
      localizationConfig:
          LocalizationConfig(assetLoader: const CodegenLoader()));
}
