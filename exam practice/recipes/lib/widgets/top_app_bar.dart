import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      backgroundColor: const Color.fromARGB(255, 178, 177, 175),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
