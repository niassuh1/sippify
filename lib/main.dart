import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassbean/constants.dart';
import 'package:glassbean/views/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor[400],
        colorScheme: colorSchemeLight,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 3,
          shadowColor: Colors.black26,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
