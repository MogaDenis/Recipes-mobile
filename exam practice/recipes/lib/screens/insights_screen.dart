import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_provider.dart';
import 'package:recipes/widgets/bottom_nav_bar.dart';
import 'package:recipes/widgets/top_app_bar.dart';
import 'package:toastification/toastification.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  bool _loadedData = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final recipesProvider =
        Provider.of<RecipesProvider>(context, listen: false);

    try {
      await recipesProvider.init();
      setState(() {
        _loadedData = true;
      });
    } catch (ex) {
      toastification.show(
        title: const Text('You are offline!'),
        autoCloseDuration: const Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipesProvider = Provider.of<RecipesProvider>(context);
    var topCategories = recipesProvider.getTopCategoriesByRating(3);

    return Scaffold(
        appBar: const TopAppBar(
          title: 'Top 3 categories by rating',
        ),
        body: _loadedData
            ? ListView.builder(
                itemCount: topCategories.length,
                itemBuilder: (ctx, index) {
                  final pair = topCategories[index];

                  return Text(
                      "Category: ${pair.key} -> Average rating: ${pair.value}");
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
