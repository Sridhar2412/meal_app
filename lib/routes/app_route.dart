import 'package:auto_route/auto_route.dart';
import 'package:meal_task_app/routes/app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: CategoryDetailRoute.page),
        AutoRoute(page: MealDetailRoute.page),
      ];
}
