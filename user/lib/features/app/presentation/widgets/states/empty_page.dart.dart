import 'package:flutter/cupertino.dart';
import 'package:naqla/core/global_widgets/app_text.dart';

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
            AppText.bodyLarge(S.of(context).there_is_nothing_to_show),
          ],
        ),
      ),
    );
  }
}
