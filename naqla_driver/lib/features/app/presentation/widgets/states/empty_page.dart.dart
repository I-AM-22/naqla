import 'package:flutter/cupertino.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/global_widgets/app_text.dart';

import '../../../../../generated/flutter_gen/assets.gen.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppImage.asset(Assets.images.svg.noDataRafiki1.path),
    );
  }
}
