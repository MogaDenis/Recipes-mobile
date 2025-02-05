import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recipes/models/recipe.dart';
import 'package:recipes/providers/recipes_provider.dart';
import 'package:recipes/widgets/bottom_nav_bar.dart';
import 'package:recipes/widgets/loader_transparent.dart';
import 'package:recipes/widgets/top_app_bar.dart';
import 'package:toastification/toastification.dart';

class AddEditScreen extends StatefulWidget {
  final Recipe? recipe;

  const AddEditScreen({super.key, this.recipe});

  @override
  State<AddEditScreen> createState() => _AddEditScreen();
}

class _AddEditScreen extends State<AddEditScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _ingredients;
  late String _category;
  late String _date;
  late double _rating;

  @override
  void initState() {
    super.initState();

    _title = widget.recipe?.title ?? '';
    _ingredients = widget.recipe?.ingredients ?? '';
    _category = widget.recipe?.category ?? '';
    _date = widget.recipe?.date ?? '';
    _rating = widget.recipe?.rating ?? 5.0;
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final recipesProvider =
          Provider.of<RecipesProvider>(context, listen: false);

      Recipe newRecipe = Recipe(
        title: _title,
        date: _date,
        ingredients: _ingredients,
        category: _category,
        rating: _rating.toDouble(),
      );

      setState(() {
        _isLoading = true;
      });

      try {
        if (widget.recipe != null) {
          newRecipe.id = widget.recipe!.id;
          await recipesProvider.updateRecipe(newRecipe);

          const snackBar = SnackBar(
            content: Text("Updated recipe"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          await recipesProvider.addRecipe(newRecipe);
        }
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

      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
          title: widget.recipe != null ? 'Edit recipe' : 'Create new recipe'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const LoaderTransparent()
            : Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _title,
                        decoration: const InputDecoration(labelText: 'Title'),
                        onChanged: (value) => _title = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: _date,
                        decoration: const InputDecoration(labelText: 'Date'),
                        onChanged: (value) => _date = value,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d{0,4}-?\d{0,2}-?\d{0,2}$'),
                          )
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a date';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: _ingredients,
                        decoration:
                            const InputDecoration(labelText: 'Ingredients'),
                        onChanged: (value) => _ingredients = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the ingredients';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: _date,
                        decoration:
                            const InputDecoration(labelText: 'Category'),
                        onChanged: (value) => _category = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a category';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: _rating.toStringAsFixed(1),
                        decoration: const InputDecoration(labelText: 'Rating'),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(5(\.0{0,2})?|[1-4](\.\d{0,2})?)$')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _rating = double.tryParse(value) ?? 1.0;
                          });
                        },
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              double.tryParse(value) == null) {
                            return 'Please enter a valid rating';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 120, 120, 120),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text("Discard changes?"),
                                        content: const Text(
                                            "Your changes will be lost"),
                                        actions: [
                                          TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, "Cancel"),
                                              child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () => {
                                                    Navigator.pop(
                                                        context, "Discard"),
                                                    Navigator.of(context).pop()
                                                  },
                                              child: const Text("Discard")),
                                        ],
                                      ));
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 71, 70, 70),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: _saveForm,
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
