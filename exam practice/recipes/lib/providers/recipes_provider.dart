import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pair/pair.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/repositories/recipes_repository.dart';
import 'package:toastification/toastification.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RecipesProvider with ChangeNotifier {
  late RecipesRepository _recipesRepository;
  List<Recipe> recipes = [];

  RecipesProvider(RecipesRepository repository) {
    _recipesRepository = repository;
  }

  Future<void> init() async {
    recipes = await _recipesRepository.loadRecipes();
  }

  void connectToWebSocket() {
    _connectToWebSocket();
  }

  List<Pair<String, double>> getTopCategoriesByRating(int topCount) {
    Set<String> categories = {};
    for (Recipe recipe in recipes) {
      categories.add(recipe.category);
    }

    Map<String, Pair<double, int>> map = {};
    for (Recipe recipe in recipes) {
      if (map.containsKey(recipe.category)) {
        var value = map[recipe.category];
        map[recipe.category] =
            Pair<double, int>(value!.key + recipe.rating, value.value + 1);
      } else {
        map[recipe.category] = Pair<double, int>(recipe.rating, 1);
      }
    }

    Map<String, double> averageRatings = {};
    for (String category in categories) {
      var value = map[category];
      double avgRating = value!.key / value.value;

      averageRatings[category] = avgRating;
    }

    var topRatings = averageRatings.values.toList()
      ..sort((a, b) => a.compareTo(b));
    topRatings = topRatings.take(topCount).toList();

    List<Pair<String, double>> results = [];
    for (String category in categories) {
      var avgRating = averageRatings[category]!;
      if (topRatings.contains(avgRating)) {
        results.add(Pair<String, double>(category, avgRating));
      }
    }

    results.sort((a, b) => b.value.compareTo(a.value));

    return results;
  }

  Map<int, double> getAverageRatingPerMonth() {
    Set<int> months = {};
    for (Recipe recipe in recipes) {
      months.add(recipe.getMonth());
    }

    Map<int, Pair<double, int>> map = {};
    for (Recipe recipe in recipes) {
      if (map.containsKey(recipe.getMonth())) {
        var value = map[recipe.getMonth()];
        map[recipe.getMonth()] =
            Pair<double, int>(value!.key + recipe.rating, value.value + 1);
      } else {
        map[recipe.getMonth()] = Pair<double, int>(recipe.rating, 1);
      }
    }

    Map<int, double> averageRatings = {};
    for (int month in months) {
      var value = map[month];
      double avgRating = value!.key / value.value;

      averageRatings[month] = avgRating;
    }

    return averageRatings;
  }

  void _connectToWebSocket() {
    final channel =
        WebSocketChannel.connect(Uri.parse('ws://localhost:2528/ws'));

    channel.stream.listen((message) {
      final data = jsonDecode(message);
      final Recipe recipe = Recipe.fromJson(data);

      recipes.insert(0, recipe);
      notifyListeners();

      toastification.show(
        title: Text('New recipe: ${recipe.title} - ${recipe.category}'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    });
  }

  Future<void> addRecipe(Recipe recipe) async {
    await _recipesRepository.addRecipe(recipe);

    // recipes.insert(0, recipe);
    // notifyListeners();
  }

  Future<void> updateRecipe(Recipe recipe) async {
    await _recipesRepository.updateRecipe(recipe);

    final index = recipes.indexWhere((e) => e.id == recipe.id);
    if (index != -1) {
      recipes[index] = recipe;
    }
    notifyListeners();
  }

  Future<void> deleteRecipe(int id) async {
    await _recipesRepository.deleteRecipe(id);

    recipes.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
