import 'package:flutter/material.dart';
import 'package:marketplace/providers/listings_provider.dart';
import 'package:marketplace/repository/listings_server_repository.dart';
import 'package:marketplace/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final listingsProvider = ListingsProvider(ListingsServerRepository());
  await listingsProvider.init();

  runApp(ChangeNotifierProvider.value(
    value: listingsProvider,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marketplace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(222, 236, 229, 217)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
