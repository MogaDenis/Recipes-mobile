import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_provider.dart';
import 'package:recipes/widgets/bottom_nav_bar.dart';
import 'package:recipes/widgets/top_app_bar.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    final recipesProvider = Provider.of<RecipesProvider>(context);
    var averageRatingsPerMonth = recipesProvider.getAverageRatingPerMonth();

    return Scaffold(
      appBar: const TopAppBar(
        title: 'Average ratings per months',
      ),
      body: ListView.builder(
        itemCount: averageRatingsPerMonth.length,
        itemBuilder: (ctx, index) {
          final month = averageRatingsPerMonth.keys.toList()[index];
          final averageRating = averageRatingsPerMonth[month];

          return Text("Month $month -> Average rating: $averageRating");
        },
      ),
      bottomNavigationBar: const BottomNavBar(
        isOnHomeScreen: true,
      ),
    );
  }
}
