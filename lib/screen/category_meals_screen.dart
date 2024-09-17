// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/widget/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/categories-meals';

  final List<Meal> availableMeals;

  const CategoryMealsScreen({
    Key? key,
    required this.availableMeals,
  }) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;

  /* @override
  void initState() {
    super.initState();
  } */

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    displayedMeals = widget.availableMeals.where(
      (meal) {
        return meal.categories.contains(categoryId);
      },
    ).toList();
    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeals!.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle!,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            title: displayedMeals![index].title,
            imageURL: displayedMeals![index].imageURL,
            duration: displayedMeals![index].duration,
            complexity: displayedMeals![index].complexity,
            affordability: displayedMeals![index].affordability,
            id: displayedMeals![index].id,
          );
        },
        itemCount: displayedMeals!.length,
      ),
    );
  }
}
