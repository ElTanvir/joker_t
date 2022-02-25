import 'package:dio/dio.dart';
import 'package:joker_t/jokes/data/categories.dart';
import 'package:joker_t/jokes/data/joke.dart';

abstract class IJokesRepository {
  Future<Categories> getCategories({required Dio dio});
  Future<Joke> getJoke(
      {required Dio dio, required String category, required String type});
}

class JokesRepo extends IJokesRepository {
  @override
  Future<Categories> getCategories({required Dio dio}) async {
    final result = await dio.get('categories');
    return Categories.fromMap(result.data);
  }

  @override
  Future<Joke> getJoke(
      {required Dio dio,
      required String category,
      required String type}) async {
    final result = await dio.get('joke/$category?type=$type');
    return Joke.fromMap(result.data);
  }
}
