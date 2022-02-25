import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joker_t/jokes/data/categories.dart';
import 'package:joker_t/jokes/data/joke.dart';
import 'package:joker_t/jokes/data/jokes_repository.dart';
import 'package:joker_t/jokes/logic/jokes_notfier.dart';
import 'package:joker_t/utils/api_state.dart';

final dioProvider = Provider((ref) {
  final Dio _dio = Dio();
  _dio.options.baseUrl = ref.watch(baseUrlProvider);
  _dio.options.connectTimeout = 10000;
  _dio.options.receiveTimeout = 10000;
  return _dio;
});
final jokesRepoProvider = Provider((ref) => JokesRepo());

final baseUrlProvider = Provider<String>((ref) => 'https://v2.jokeapi.dev/');

final currentCategoryProvider = StateNotifierProvider<CategoryNotifier, String>(
    (ref) => CategoryNotifier());
final currentTypeProvider = StateNotifierProvider<TypeNotifier, String>(
    (ref) => TypeNotifier(ref.watch(currentCategoryProvider)));

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, ApiState<Categories>>((ref) {
  return CategoriesNotifier(
      ref.watch(jokesRepoProvider), ref.watch(dioProvider));
});
final typesProvider = StateNotifierProvider<TypesNotifier, List<String>>((ref) {
  return TypesNotifier(ref.watch(currentCategoryProvider));
});
final jokesProvider =
    StateNotifierProvider<JokesNotifier, ApiState<Joke>>((ref) {
  return JokesNotifier(ref.watch(jokesRepoProvider), ref.watch(dioProvider),
      ref.watch(currentCategoryProvider), ref.watch(currentTypeProvider));
});
