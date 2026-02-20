import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_task_app/service/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'meal_provider.g.dart';

@riverpod
class MealNotifier extends _$MealNotifier {
  @override
  List<Meal> build() {
    return <Meal>[];
  }

  Future<void> getMealList({required String category}) async {
    final api = await ref.read(dioProvider).getMealList(category: category);

    List<dynamic> list = api['data'];
    final List<Meal> mealList = [];
    list.forEach((e) {
      mealList.add((Meal(
        idMeal: e['idMeal'],
        strMeal: e['strMeal'],
        strMealThumb: e['strMealThumb'],
        strInstructions: e['strInstructions'],
        strCategory: e['strCategory'],
      )));
    });
    state = mealList;
  }

  Future<void> searchMeal({required String meal}) async {
    final api = await ref.read(dioProvider).searchMeal(meal: meal);

    List<dynamic> list = api['data'];
    final List<Meal> mealList = [];
    list.forEach((e) {
      mealList.add((Meal(
        idMeal: e['idMeal'],
        strMeal: e['strMeal'],
        strMealThumb: e['strMealThumb'],
        strInstructions: e['strInstructions'],
        strCategory: e['strCategory'],
      )));
    });
    state = mealList;
  }

  Future<void> getRandomMeal() async {
    final api = await ref.read(dioProvider).getRandomMeal();

    List<dynamic> list = api['data'];
    final List<Meal> mealList = [];
    list.forEach((e) {
      mealList.add((Meal(
        idMeal: e['idMeal'],
        strMeal: e['strMeal'],
        strMealThumb: e['strMealThumb'],
        strInstructions: e['strInstructions'],
        strCategory: e['strCategory'],
      )));
    });
    state = mealList;
  }
}

@riverpod
class MealDetailNotifier extends _$MealDetailNotifier {
  @override
  Meal build() {
    return Meal(
        idMeal: '',
        strMeal: '',
        strMealThumb: '',
        strCategory: '',
        strInstructions: '');
  }

  Future<void> getMealById({required int mealId}) async {
    final api = await ref.read(dioProvider).getMealById(mealId: mealId);

    List<dynamic> list = api['data'];
    final List<Meal> mealList = [];
    list.forEach((e) {
      mealList.add((Meal(
        idMeal: e['idMeal'],
        strMeal: e['strMeal'],
        strMealThumb: e['strMealThumb'],
        strInstructions: e['strInstructions'],
        strCategory: e['strCategory'],
      )));
    });
    state = mealList[0];
  }

  Future<void> searchMeal({required String meal}) async {
    final api = await ref.read(dioProvider).searchMeal(meal: meal);

    List<dynamic> list = api['data'];
    final List<Meal> mealList = [];
    list.forEach((e) {
      mealList.add((Meal(
        idMeal: e['idMeal'],
        strMeal: e['strMeal'],
        strMealThumb: e['strMealThumb'],
        strInstructions: e['strInstructions'],
        strCategory: e['strCategory'],
      )));
    });
    state = mealList[0];
  }
}

class Meal {
  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.strInstructions,
    this.strCategory,
  });

  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  final String? strCategory;

  final String? strInstructions;
}
