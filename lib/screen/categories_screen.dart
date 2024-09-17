import 'package:flutter/material.dart';

import 'package:flutter_meals_app/data/dummy_data.dart';
import 'package:flutter_meals_app/widget/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(25),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: DUMMY_CATEGORIES.length,
      itemBuilder: (context, index) {
        final catData = DUMMY_CATEGORIES[index];
        return CategoryItem(
          title: catData.title,
          color: catData.color,
          id: catData.id,
        );
      },
    );
  }
}
