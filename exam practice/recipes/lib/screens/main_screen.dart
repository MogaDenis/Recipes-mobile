import 'package:flutter/material.dart';
import 'package:recipes/widgets/loader_transparent.dart';
import 'package:recipes/widgets/recipe_list_item.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_provider.dart';
import 'package:recipes/widgets/bottom_nav_bar.dart';
import 'package:recipes/widgets/top_app_bar.dart';
import 'package:toastification/toastification.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _loadedData = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final recipesProvider =
        Provider.of<RecipesProvider>(context, listen: false);

    setState(() {
      _isLoading = true;
    });

    try {
      await recipesProvider.init();
      recipesProvider.connectToWebSocket();

      setState(() {
        _loadedData = true;
      });
    } catch (ex) {
      toastification.show(
        type: ToastificationType.error,
        title: const Text('You are offline!'),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipesProvider = Provider.of<RecipesProvider>(context);

    return Scaffold(
        appBar: const TopAppBar(
          title: 'Recipes',
        ),
        body: _isLoading
            ? const LoaderTransparent()
            : _loadedData
                ? ListView.builder(
                    itemCount: recipesProvider.recipes.length,
                    itemBuilder: (ctx, index) {
                      final recipe = recipesProvider.recipes[index];

                      return RecipeListItem(recipe: recipe);
                    },
                  )
                : Center(
                    child: FloatingActionButton(
                    onPressed: () async => _loadData(),
                    child: const Text("Retry"),
                  )),
        bottomNavigationBar: const BottomNavBar(
          isOnHomeScreen: true,
        ));
  }
}
