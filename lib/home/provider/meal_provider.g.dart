// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mealNotifierHash() => r'4bd61d406cd4c64f7f778f1fcd3a61bbba27a125';

/// See also [MealNotifier].
@ProviderFor(MealNotifier)
final mealNotifierProvider =
    AutoDisposeNotifierProvider<MealNotifier, List<Meal>>.internal(
  MealNotifier.new,
  name: r'mealNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mealNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MealNotifier = AutoDisposeNotifier<List<Meal>>;
String _$mealDetailNotifierHash() =>
    r'b45eaeeb110f016802a7aff8f59cc0447d93bc44';

/// See also [MealDetailNotifier].
@ProviderFor(MealDetailNotifier)
final mealDetailNotifierProvider =
    AutoDisposeNotifierProvider<MealDetailNotifier, Meal>.internal(
  MealDetailNotifier.new,
  name: r'mealDetailNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mealDetailNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MealDetailNotifier = AutoDisposeNotifier<Meal>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
