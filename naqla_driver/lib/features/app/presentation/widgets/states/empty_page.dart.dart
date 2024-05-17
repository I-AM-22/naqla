import 'package:flutter/cupertino.dart';
import 'package:naqla_driver/core/global_widgets/app_text.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppText.bodyLarge('There is nothing to show'),
    );
  }
}
