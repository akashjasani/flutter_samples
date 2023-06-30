import 'package:flutter/material.dart';
import './screens/filter_screen.dart';
import './screens/TabScreen.dart';
import 'screens/category_meal_screen.dart';
import './screens/category_screen.dart';
import './screens/meal_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DailyMeal',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge:
                  const TextStyle(color: Color.fromRGBO(255, 254, 229, 1)),
              bodyMedium:
                  const TextStyle(color: Color.fromRGBO(255, 254, 229, 1)),
              bodySmall:
                  const TextStyle(color: Color.fromRGBO(255, 254, 229, 1)),
              titleLarge: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'),
            ),
      ),
      // home: Category(),
      initialRoute: TabScreen.routName,
      routes: {
        TabScreen.routName: (context) => TabScreen(),
        CategoryMealScreen.routName: (context) => CategoryMealScreen(),
        MealDetailScreen.routName: (context) => MealDetailScreen(),
        FilterScreen.routName: (context) => FilterScreen(),
      },
    );
  }
}
