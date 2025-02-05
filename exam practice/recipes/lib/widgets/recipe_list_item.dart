import 'package:flutter/material.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/screens/recipe_details_screen.dart';

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeListItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(recipe: recipe)));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text("Category: ${recipe.category}"),
                        const SizedBox(height: 5),
                        Text("Date: ${recipe.date}"),
                        const SizedBox(height: 5),
                        Text("Ingredients: ${recipe.ingredients}"),
                        const SizedBox(height: 5),
                        Text(
                            "Rating: ${recipe.rating.toStringAsFixed(1)} / 5.0"),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
