import 'package:auto_route/auto_route.dart';

import 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRouteGuard> get guards => [];

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      initial: true,
    ),
  ];
}
