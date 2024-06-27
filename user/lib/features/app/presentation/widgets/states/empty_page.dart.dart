import 'package:flutter/cupertino.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/global_widgets/app_text.dart';

import '../../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: double.infinity,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            AppImage.asset(Assets.images.svg.noDataRafiki1.path),
          ],
        ),
      ),
    );
  }
}
