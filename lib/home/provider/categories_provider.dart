import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_task_app/service/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'categories_provider.g.dart';

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  List<Category> build() {
    return <Category>[];
  }

  Future<void> getCategoryList() async {
    final api = await ref.read(dioProvider).getCategoriesList();

    List<dynamic> list = api['data'];
    final List<Category> catList = [];
    list.forEach((e) {
      catList.add((Category(
          idCategory: e['idCategory'],
          strCategory: e['strCategory'],
          strCategoryThumb: e['strCategoryThumb'],
          strCategoryDescription: e['strCategoryDescription'])));
    });
    state = catList;
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
