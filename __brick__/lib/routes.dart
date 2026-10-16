import 'package:auto_route/auto_route.dart';

import 'features/home/screens/home_screen.dart';

class AppRouter() extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRouteGuard> get guards => [];

  @override
  List<AutoRoute> get routes => [
    NamedRouteDef(
      name: 'HomeRoute',
      path: '/',
      initial: true,
      builder: (context, data) => const HomeScreen(),
    ),
  ];
}
