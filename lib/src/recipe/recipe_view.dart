import 'package:flutter/material.dart';

import 'recipe_item.dart';

class RecipeView extends StatelessWidget {
  final Recipe recipe;
  const RecipeView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: ListView(
        children: [
          Image.asset(recipe.imageUri, fit: BoxFit.cover),
          Text(recipe.shortDescription),
          //IngredientsView(ingredients: recipe.ingredients,),
          Text(recipe.description),
        ],
      ),
    );
  }
}

class IngredientsView extends StatelessWidget {
  final List<Ingredient> ingredients;
  const IngredientsView({super.key, required this.ingredients});

  buildIngredients() =>
      ingredients.map((e) => IngredientView(ingredient: e)).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buildIngredients(),
    );
  }
}

class IngredientView extends StatefulWidget {
  final Ingredient ingredient;
  const IngredientView({super.key, required this.ingredient});

  @override
  State<IngredientView> createState() => _IngredientViewState();
}

class _IngredientViewState extends State<IngredientView> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? v) => {
            setState(() {
              isChecked = v!;
            })
          },
        ),
        Text(
            '${widget.ingredient.amount}${widget.ingredient.unit} ${widget.ingredient.name}',
            style: isChecked
                ? const TextStyle(decoration: TextDecoration.lineThrough)
                : const TextStyle()),
      ],
    );
  }
}
