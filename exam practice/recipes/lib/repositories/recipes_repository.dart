import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipes/models/recipe.dart';

class RecipesRepository {
  final baseURI = "http://192.168.100.54:2528";

  Future<List<Recipe>> loadRecipes() async {
    final response = await http
        .get(Uri.parse("$baseURI/recipes"))
        .timeout(const Duration(seconds: 3), onTimeout: () {
      throw Exception("Couldn't communicate with the server.");
    });

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);

      return jsonData.map((data) => Recipe.fromJson(data)).toList();
    } else {
      throw Exception("Failed to load recipes!");
    }
  }

  Future<void> addRecipe(Recipe recipe) async {
    final response = await http
        .post(Uri.parse("$baseURI/recipe"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(recipe.toJson()))
        .timeout(const Duration(seconds: 3), onTimeout: () {
      throw Exception("Couldn't communicate with the server.");
    });

    if (response.statusCode != 201) {
      debugPrint("Failed to add recipe!");
      throw Exception("Failed to add recipe!");
    }

    debugPrint("Added a new recipe!");
  }

  Future<void> updateRecipe(Recipe recipe) async {
    final response = await http
        .put(Uri.parse("$baseURI/recipe/${recipe.id}"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(recipe.toJson()))
        .timeout(const Duration(seconds: 3), onTimeout: () {
      throw Exception("Couldn't communicate with the server.");
    });

    if (response.statusCode != 200) {
      debugPrint("Failed to update recipe!");
      throw Exception("Failed to update recipe!");
    }

    debugPrint("Updated recipe with id ${recipe.id}");
  }

  Future<void> deleteRecipe(int id) async {
    final response = await http
        .delete(Uri.parse("$baseURI/recipe/$id"))
        .timeout(const Duration(seconds: 3), onTimeout: () {
      throw Exception("Couldn't communicate with the server.");
    });

    if (response.statusCode != 200) {
      debugPrint("Failed to remove recipe!");
      throw Exception("Failed to remove recipe!");
    }

    debugPrint("Deleted recipe with id $id");
  }
}
