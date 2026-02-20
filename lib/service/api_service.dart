import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = StateProvider<ApiService>((ref) {
  return ApiService();
});

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.themealdb.com/api/json/v1/1',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    ),
  );

  Future<Map<String, dynamic>> getCategoriesList() async {
    try {
      final response = await dio.get('/categories.php');
      print('${response.data}');
      return {
        'code': 200,
        'status': 'Success',
        'data': response.data['categories']
      };
    } on DioException catch (e) {
      if (e.response != null) {
        print('${e.response?.statusCode}');
        return {'code': e.response?.statusCode};
      } else {
        print('${e.message}');
        return {'message': e.message};
      }
    }
  }

  Future<Map<String, dynamic>> getMealList({required String category}) async {
    try {
      final response = await dio.get('/filter.php?c=$category');
      print('${response.data}');
      return {'code': 200, 'status': 'Success', 'data': response.data['meals']};
    } on DioException catch (e) {
      if (e.response != null) {
        print('${e.response?.statusCode}');
        return {'code': e.response?.statusCode};
      } else {
        print('${e.message}');
        return {'message': e.message};
      }
    }
  }

  Future<Map<String, dynamic>> getMealById({required int mealId}) async {
    try {
      final response = await dio.get('/lookup.php?i=$mealId');
      print('${response.data}');
      return {'code': 200, 'status': 'Success', 'data': response.data['meals']};
    } on DioException catch (e) {
      if (e.response != null) {
        print('${e.response?.statusCode}');
        return {'code': e.response?.statusCode};
      } else {
        print('${e.message}');
        return {'message': e.message};
      }
    }
  }

  Future<Map<String, dynamic>> getRandomMeal() async {
    try {
      final response = await dio.get('/random.php');
      print('${response.data}');
      return {'code': 200, 'status': 'Success', 'data': response.data['meals']};
    } on DioException catch (e) {
      if (e.response != null) {
        print('${e.response?.statusCode}');
        return {'code': e.response?.statusCode};
      } else {
        print('${e.message}');
        return {'message': e.message};
      }
    }
  }

  Future<Map<String, dynamic>> searchMeal({required String meal}) async {
    try {
      final response = await dio.get('/search.php?s=$meal');
      print('${response.data}');
      return {'code': 200, 'status': 'Success', 'data': response.data['meals']};
    } on DioException catch (e) {
      if (e.response != null) {
        print('${e.response?.statusCode}');
        return {'code': e.response?.statusCode};
      } else {
        print('${e.message}');
        return {'message': e.message};
      }
    }
  }
}
