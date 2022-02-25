import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joker_t/jokes/data/categories.dart';
import 'package:joker_t/jokes/data/joke.dart';
import 'package:joker_t/jokes/data/jokes_repository.dart';
import 'package:joker_t/utils/api_state.dart';
import 'package:joker_t/utils/network_exceptions.dart';

class CategoriesNotifier extends StateNotifier<ApiState<Categories>> {
  final IJokesRepository _jokesRepository;
  final Dio dio;
  CategoriesNotifier(this._jokesRepository, this.dio)
      : super(const ApiState.initial()) {
    getCategories();
  }

  Future<void> getCategories() async {
    try {
      state = const ApiState.loading();
      final Categories categories =
          await _jokesRepository.getCategories(dio: dio);
      state = ApiState.loaded(data: categories);
    } catch (e) {
      state = ApiState.error(
        error: NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(e),
        ),
      );
    }
  }
}

class JokesNotifier extends StateNotifier<ApiState<Joke>> {
  final IJokesRepository _jokesRepository;
  final Dio dio;
  final String category;
  final String type;
  JokesNotifier(this._jokesRepository, this.dio, this.category, this.type)
      : super(const ApiState.initial()) {
    getJokes();
  }

  Future<void> getJokes() async {
    try {
      state = const ApiState.loading();
      final Joke joke = await _jokesRepository.getJoke(
          dio: dio, category: category, type: type);
      state = ApiState.loaded(data: joke);
    } catch (e) {
      state = ApiState.error(
        error: NetworkExceptions.getErrorMessage(
          NetworkExceptions.getDioException(e),
        ),
      );
    }
  }
}

class TypesNotifier extends StateNotifier<List<String>> {
  final String category;
  TypesNotifier(this.category) : super([]) {
    if (category.toLowerCase() == 'spooky' ||
        category.toLowerCase() == 'christmas') {
      state = ['twopart'];
    } else {
      state = ['single', 'twopart'];
    }
  }
}

class CategoryNotifier extends StateNotifier<String> {
  CategoryNotifier() : super('Any');
  set stateValue(String value) {
    state = value;
  }

  String get stateValue => state;
}

class TypeNotifier extends StateNotifier<String> {
  final String category;
  TypeNotifier(this.category) : super('single') {
    if (category.toLowerCase() == 'spooky' ||
        category.toLowerCase() == 'christmas') {
      state = 'twopart';
    }
  }

  set stateValue(String value) {
    state = value;
  }

  String get stateValue => state;
}
