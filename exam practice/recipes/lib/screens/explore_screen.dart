import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_provider.dart';
import 'package:recipes/widgets/bottom_nav_bar.dart';
import 'package:recipes/widgets/top_app_bar.dart';
import 'package:toastification/toastification.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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
    var averageRatingsPerMonth = recipesProvider.getAverageRatingPerMonth();

    return Scaffold(
        appBar: const TopAppBar(
          title: 'Average ratings per months',
        ),
        body: _loadedData
            ? ListView.builder(
                itemCount: averageRatingsPerMonth.length,
                itemBuilder: (ctx, index) {
                  final month = averageRatingsPerMonth.keys.toList()[index];
                  final averageRating = averageRatingsPerMonth[month];

                  return Text("Month $month -> Average rating: $averageRating");
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
