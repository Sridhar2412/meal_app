import 'package:meal_task_app/service/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'categories_provider.g.dart';

class CategoryState {
  final List<Category> categories;
  final bool isLoading;
  final String? error;

  CategoryState({
    required this.categories,
    this.isLoading = false,
    this.error,
  });

  CategoryState copyWith({
    List<Category>? categories,
    bool? isLoading,
    String? error,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  CategoryState build() {
    return CategoryState(categories: []);
  }

  Future<void> getCategoryList() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final api = await ref.read(dioProvider).getCategoriesList();

      List<dynamic> list = api['data'];
      final List<Category> catList = [];
      for (var e in list) {
        catList.add((Category(
            idCategory: e['idCategory'],
            strCategory: e['strCategory'],
            strCategoryThumb: e['strCategoryThumb'],
            strCategoryDescription: e['strCategoryDescription'])));
      }
      state = state.copyWith(categories: catList, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

class Category {
  Category({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;
}
