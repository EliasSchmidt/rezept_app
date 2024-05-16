import 'package:flutter/material.dart';

import 'package:rezept_app/src/recipe/recipe_item.dart';
import 'package:rezept_app/src/recipe/recipe_view.dart';

class RecipeListView extends StatelessWidget {
  final List<Recipe> recipes;
  static const String routeName = '/RecipeListView';
  const RecipeListView({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return RecepieListItem(recipe: recipes[index]);
        },
      ),
    );
  }
}

class RecepieListItem extends StatelessWidget {
  final Recipe recipe;
  const RecepieListItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeView(recipe: recipe,)));},
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            Ink.image(image: Image.asset(recipe.imageUri).image, height: 80, width: 80),
            Text(recipe.title),
          ],
        ),
      ),
    );
  }
}