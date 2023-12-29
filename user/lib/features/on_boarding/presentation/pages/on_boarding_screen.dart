import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:user/core/config/themes/my_color_scheme.dart';
import 'package:user/core/config/themes/typography.dart';
import 'package:user/core/util/extensions/build_context.dart';
import 'package:user/core/util/responsive_padding.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/app_text_view.dart';
import 'package:user/features/app/presentation/widgets/naqla_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';
import 'package:user/features/on_boarding/presentation/widget/on_boarding_slide.dart';
import 'package:user/gen/assets.gen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: NaqlaAppBar(
          appBarParams: AppBarParams(
              backgroundColor: context.colorScheme.background,
              action: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Skip',
                    style: context.textTheme.subHead
                        .withColor(context.colorScheme.onTertiary),
                  ),
                )
              ]),
          isLeading: false,
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          allowImplicitScrolling: false,
          pageSnapping: false,
          children: [
            OnBoardingSlide(
              num: 0.9,
              title: 'Anywhere you are',
              content:
                  'Sell houses easily with the help of Listenoryx and to make this line bigI am writing more.',
              path: Assets.lottie.car2,
              onPressed: () {
                print(_pageController.page);
                _pageController.jumpToPage(_pageController.page!.toInt() + 1);
              },
            ),
            OnBoardingSlide(
              num: 1.6,
              title: 'At anytime',
              content:
                  'Sell houses easily with the help of Listenoryx and to make this line big I am writing more.',
              path: Assets.lottie.car3,
              onPressed: () {
                _pageController.jumpToPage(_pageController.page!.toInt() + 1);
              },
            ),
            OnBoardingSlide(
              num: 2.5,
              title: 'Anywhere you are',
              content:
                  'Sell houses easily with the help of Listenoryx and to make this line bigI am writing more.',
              path: Assets.lottie.car2,
              onPressed: () {
                _pageController.jumpToPage(_pageController.initialPage);
              },
            ),
          ],
        ));
  }
}
