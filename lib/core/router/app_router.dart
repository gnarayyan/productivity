import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: PersonalProductivityRoute.page, initial: true),
    AutoRoute(page: AuthDemoRoute.page),
    AutoRoute(page: LoginRoute.page),
     AutoRoute(page: NoInternetRoute.page),
      AutoRoute(page: ServerMaintenanceRoute.page),
       AutoRoute(page: SplashRoute.page),
        AutoRoute(page: SignupRoute.page),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    // optionally add root guards here
  ];
}
