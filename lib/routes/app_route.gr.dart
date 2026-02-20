// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:meal_task_app/auth/login_page.dart' as _i3;
import 'package:meal_task_app/home/category_detail_page.dart' as _i1;
import 'package:meal_task_app/home/home_page.dart' as _i2;
import 'package:meal_task_app/home/meal_detail_page.dart' as _i4;
import 'package:meal_task_app/splash_page.dart' as _i5;

/// generated route for
/// [_i1.CategoryDetailPage]
class CategoryDetailRoute extends _i6.PageRouteInfo<CategoryDetailRouteArgs> {
  CategoryDetailRoute({
    _i7.Key? key,
    required String category,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         CategoryDetailRoute.name,
         args: CategoryDetailRouteArgs(key: key, category: category),
         initialChildren: children,
       );

  static const String name = 'CategoryDetailRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryDetailRouteArgs>();
      return _i1.CategoryDetailPage(key: args.key, category: args.category);
    },
  );
}

class CategoryDetailRouteArgs {
  const CategoryDetailRouteArgs({this.key, required this.category});

  final _i7.Key? key;

  final String category;

  @override
  String toString() {
    return 'CategoryDetailRouteArgs{key: $key, category: $category}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CategoryDetailRouteArgs) return false;
    return key == other.key && category == other.category;
  }

  @override
  int get hashCode => key.hashCode ^ category.hashCode;
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginPage();
    },
  );
}

/// generated route for
/// [_i4.MealDetailPage]
class MealDetailRoute extends _i6.PageRouteInfo<MealDetailRouteArgs> {
  MealDetailRoute({
    _i7.Key? key,
    required int mealId,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         MealDetailRoute.name,
         args: MealDetailRouteArgs(key: key, mealId: mealId),
         initialChildren: children,
       );

  static const String name = 'MealDetailRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MealDetailRouteArgs>();
      return _i4.MealDetailPage(key: args.key, mealId: args.mealId);
    },
  );
}

class MealDetailRouteArgs {
  const MealDetailRouteArgs({this.key, required this.mealId});

  final _i7.Key? key;

  final int mealId;

  @override
  String toString() {
    return 'MealDetailRouteArgs{key: $key, mealId: $mealId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MealDetailRouteArgs) return false;
    return key == other.key && mealId == other.mealId;
  }

  @override
  int get hashCode => key.hashCode ^ mealId.hashCode;
}

/// generated route for
/// [_i5.SplashPage]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute({List<_i6.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.SplashPage();
    },
  );
}
