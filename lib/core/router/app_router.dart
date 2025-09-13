import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LandingRoute.page, initial: true),
    AutoRoute(page: TodoRoute.page),
    AutoRoute(page: AddTodoRoute.page),
    AutoRoute(page: EditTodoRoute.page),
    AutoRoute(page: MethodChannelRoute.page),
    AutoRoute(page: DynamicFormRoute.page),
    AutoRoute(page: EcommerceRoute.page),
    AutoRoute(page: NestedBottomNavRoute.page),
    AutoRoute(page: ProductivityMainRoute.page),
    AutoRoute(page: AuthDemoRoute.page),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    // optionally add root guards here
  ];
}
