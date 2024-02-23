import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/auth/presentation/pages/set_location_page.dart';
import 'package:naqla/features/on_boarding/presentation/widget/on_boarding_slide.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const String path = "/OnBoardingScreen";
  static const String name = "/OnBoardingScreen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(
              backgroundColor: context.colorScheme.background,
              action: [
                TextButton(
                  onPressed: () => context.goNamed(SetLocationPage.name),
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
              title: S.of(context).anywhere_you_are,
              content:
                  S.of(context).sell_houses_easily_with_the_help_of_Listenoryx,
              path: Assets.lottie.car4.path,
              onPressed: () {
                _pageController.jumpToPage(_pageController.page!.toInt() + 1);
              },
            ),
            OnBoardingSlide(
              num: 1.6,
              title: S.of(context).at_anytime,
              content:
                  S.of(context).sell_houses_easily_with_the_help_of_Listenoryx,
              path: Assets.lottie.car3.path,
              onPressed: () {
                _pageController.jumpToPage(_pageController.page!.toInt() + 1);
              },
            ),
            OnBoardingSlide(
              num: 2.5,
              title: S.of(context).book_your_car,
              content:
                  S.of(context).sell_houses_easily_with_the_help_of_Listenoryx,
              path: Assets.lottie.car2.path,
              onPressed: () {
                context.goNamed(SetLocationPage.name);
              },
            ),
          ],
        ));
  }
}
