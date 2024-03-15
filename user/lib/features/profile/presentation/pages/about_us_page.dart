import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';

import '../../../../generated/l10n.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  static const String name = 'AboutUsPage';

  static const String path = 'AboutUsPage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(appBarParams: AppBarParams(title: S.of(context).about_us)),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: UIConstants.screenPadding30),
          child: AppText.bodyMedium(
              'Professional Ride-share Platform. Here we will provide you only interesting content, which you will like very much. We\'re dedicated to providing you the best of Rideshare, with a focus on dependability and Earning. We\'re working to turn our passion for Rideshare into a booming online website. We hope you enjoy our Rideshare as much as we enjoy offering them to you. I will keep posting more important posts on my Website for all of you. Please give your support and love.Professional Rideshare Platform. Here we will provide you only interesting content, which you will like very much. We\'re dedicated to providing you the best of Rideshare, with a focus on dependability and Earning. We\'re working to turn our passion for Rideshare into a booming online website. We hope you enjoy our Rideshare as much as we enjoy offering them to you. I will keep posting more important posts on my Website for all of you. Please give your support and love.'),
        ));
  }
}
