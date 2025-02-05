import 'package:flutter/material.dart';
import 'package:recipes/screens/add_edit_screen.dart';
import 'package:recipes/screens/explore_screen.dart';
import 'package:recipes/screens/insights_screen.dart';

class BottomNavBar extends StatelessWidget {
  final bool isOnHomeScreen;

  const BottomNavBar({super.key, this.isOnHomeScreen = false});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 178, 177, 175),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      onTap: (index) {
        switch (index) {
          case 0:
            {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ExploreScreen()));
            }
          case 1:
            {
              if (isOnHomeScreen) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddEditScreen()));
              } else {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            }
          case 2:
            {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InsightsScreen()));
            }
        }
      },
      items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.explore), label: 'Explore'),
        isOnHomeScreen
            ? const BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Add',
              )
            : const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.insights), label: 'Insights'),
      ],
    );
  }
}
