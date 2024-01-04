class RouterConfiguration {
  RouterConfiguration.init();
  final String splashScreen = '/splash';
  final authRoutes = const AuthRoutes._();
  final onBoardingRoutes = _OnBoardingRoutes._();
  final homeScreen = const _HomeRoutes._();
}

class AuthRoutes {
  const AuthRoutes._();

  final String setLocation = '/setLocation';
  final String welcome = '/welcome';
  final String login = '/login';
  final String signup = '/signup';
  final String forgotPassword = '/forgotPassword';
  final String resetPassword = '/resetPassword';
}

class _OnBoardingRoutes {
  _OnBoardingRoutes._();
  final String onBoarding = '/onBoarding';
}

class _HomeRoutes {
  const _HomeRoutes._();

  final String homeScreen = '/homeScreen';
}
