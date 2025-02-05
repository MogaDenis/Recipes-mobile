import 'package:flutter/material.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/screens/add_edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_provider.dart';
import 'package:recipes/widgets/bottom_nav_bar.dart';
import 'package:recipes/widgets/loader_transparent.dart';
import 'package:recipes/widgets/top_app_bar.dart';
import 'package:toastification/toastification.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final recipesProvider = Provider.of<RecipesProvider>(context);

    void onDelete() async {
      Navigator.pop(context, "Delete");

      setState(() {
        _isLoading = true;
      });

      try {
        await recipesProvider.deleteRecipe(widget.recipe.id);

        const snackBar = SnackBar(
          content: Text("Deleted recipe"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } on Exception catch (ex) {
        // var snackBar = SnackBar(
        //   content: Text(ex.toString().split(": ").last),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);

        toastification.show(
          type: ToastificationType.error,
          title: Text(ex.toString().split(": ").last),
          autoCloseDuration: const Duration(seconds: 3),
        );
      }

      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: const TopAppBar(
        title: 'Details',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _isLoading
              ? const LoaderTransparent()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.title,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Date: ${widget.recipe.date}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Category: ${widget.recipe.category}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Ingredients: ${widget.recipe.ingredients}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Rating: ${widget.recipe.rating.toStringAsFixed(1)} / 5.0',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AddEditScreen(recipe: widget.recipe)));
                          },
                          child: const Text('Edit'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text("Delete confirmation"),
                                      content: const Text(
                                          "Are you sure you want to delete this recipe?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, "Cancel"),
                                            child: const Text("Cancel")),
                                        TextButton(
                                            onPressed: onDelete,
                                            child: const Text("Delete")),
                                      ],
                                    ));
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
