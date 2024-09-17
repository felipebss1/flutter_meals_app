import 'package:flutter/material.dart';
import 'package:flutter_meals_app/data/dummy_data.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/screen/categories_screen.dart';
import 'package:flutter_meals_app/screen/category_meals_screen.dart';
import 'package:flutter_meals_app/screen/filters_screen.dart';
import 'package:flutter_meals_app/screen/meal_detail_screen.dart';
import 'package:flutter_meals_app/screen/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Map<String, bool> _filters;

  _MyAppState() {
    _filters = {
      'gluten': false,
      'lactose': false,
      'vegan': false,
      'vegetarian': false,
    };
  }
  List<Meal> _availableMeals = DUMMY_MEALS;
  final List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    final glutenFree = _filters['gluten']!;
    final lactoseFree = _filters['lactose']!;
    final vegan = _filters['vegan']!;
    final vegetarian = _filters['vegetarian']!;

    setState(() {
      _availableMeals = DUMMY_MEALS
          .where((meal) =>
              (!glutenFree || meal.isGlutenFree) &&
              (!lactoseFree || meal.isLactoseFree) &&
              (!vegan || meal.isVegan) &&
              (!vegetarian || meal.isVegetarian))
          .toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingMeal = _favoriteMeals.firstWhere(
      (meal) => meal.id == mealId,
      orElse: () => DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
    );
    setState(() {
      if (_favoriteMeals.contains(existingMeal)) {
        _favoriteMeals.remove(existingMeal);
      } else {
        _favoriteMeals.add(existingMeal);
      }
    });
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyMedium: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(
              favoriteMeals: _favoriteMeals,
            ),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
              availableMeals: _availableMeals,
            ),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              toggleFavorite: _toggleFavorite,
              isFavorite: _isMealFavorite,
            ),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              currentFilters: _filters,
              saveFilters: _setFilters,
            ),
      },
      onGenerateRoute: (settings) {
        return null;
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => const CategoriesScreen(),
        );
      },
    );
  }
}
