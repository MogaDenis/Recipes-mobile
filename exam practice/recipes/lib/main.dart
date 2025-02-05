import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes/providers/recipes_provider.dart';
import 'package:recipes/repositories/recipes_repository.dart';
import 'package:recipes/screens/main_screen.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final listingsProvider = RecipesProvider(RecipesRepository());

  runApp(ChangeNotifierProvider.value(
    value: listingsProvider,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Recipes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(222, 236, 229, 217)),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
