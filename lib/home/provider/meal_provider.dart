import 'package:meal_task_app/service/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'meal_provider.g.dart';

class MealState {
  final List<Meal> meals;
  final bool isLoading;
  final String? error;

  MealState({
    required this.meals,
    this.isLoading = false,
    this.error,
  });

  MealState copyWith({
    List<Meal>? meals,
    bool? isLoading,
    String? error,
  }) {
    return MealState(
      meals: meals ?? this.meals,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class MealDetailState {
  final Meal? meal;
  final bool isLoading;
  final String? error;

  MealDetailState({
    this.meal,
    this.isLoading = false,
    this.error,
  });

  MealDetailState copyWith({
    Meal? meal,
    bool? isLoading,
    String? error,
  }) {
    return MealDetailState(
      meal: meal ?? this.meal,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

@riverpod
class MealNotifier extends _$MealNotifier {
  @override
  MealState build() {
    return MealState(meals: []);
  }

  Future<void> getMealList({required String category}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
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
      state = state.copyWith(meals: mealList, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> searchMeal({required String meal}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
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
      state = state.copyWith(meals: mealList, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> getRandomMeal() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
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
      state = state.copyWith(meals: mealList, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

@riverpod
class MealDetailNotifier extends _$MealDetailNotifier {
  @override
  MealDetailState build() {
    return MealDetailState();
  }

  Future<void> getMealById({required int mealId}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final api = await ref.read(dioProvider).getMealById(mealId: mealId);

      List<dynamic> list = api['data'];
      if (list.isNotEmpty) {
        final e = list[0];
        final meal = Meal(
          idMeal: e['idMeal'],
          strMeal: e['strMeal'],
          strMealThumb: e['strMealThumb'],
          strInstructions: e['strInstructions'],
          strCategory: e['strCategory'],
        );
        state = state.copyWith(meal: meal, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false, error: 'Meal not found');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
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
