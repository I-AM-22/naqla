import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user/core/config/router/router.dart';
import 'package:user/core/core.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';
import 'package:user/features/on_boarding/presentation/widget/on_boarding_slide.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: CustomerAppBar(
          appBarParams: AppBarParams(
              backgroundColor: context.colorScheme.background,
              action: [
                TextButton(
                  onPressed: () =>
                      context.goNamed(GRouter.config.authRoutes.setLocation),
                  child: AppText.subHeadRegular(
                    'Skip',
                    color: context.colorScheme.onTertiary,
                  ),
                )
              ]),
          back: false,
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
              path: Assets.lottie.car4.path,
              onPressed: () {
                _pageController.jumpToPage(_pageController.page!.toInt() + 1);
              },
            ),
            OnBoardingSlide(
              num: 1.6,
              title: 'At anytime',
              content:
                  'Sell houses easily with the help of Listenoryx and to make this line big I am writing more.',
              path: Assets.lottie.car3.path,
              onPressed: () {
                _pageController.jumpToPage(_pageController.page!.toInt() + 1);
              },
            ),
            OnBoardingSlide(
              num: 2.49,
              title: 'Anywhere you are',
              content:
                  'Sell houses easily with the help of Listenoryx and to make this line bigI am writing more.',
              path: Assets.lottie.car2.path,
              onPressed: () {
                context.goNamed(GRouter.config.authRoutes.setLocation);
              },
            ),
          ],
        ));
  }
}
