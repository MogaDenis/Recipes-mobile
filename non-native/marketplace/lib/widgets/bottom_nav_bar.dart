import 'package:flutter/material.dart';
import 'package:marketplace/screens/add_edit_screen.dart';

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
        if (index == 1) {
          if (isOnHomeScreen) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddEditScreen()));
          } else {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        }
      },
      items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.person), label: 'Profile'),
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
            icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
