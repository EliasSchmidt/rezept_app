import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:rezept_app/src/database/models/ingredient.dart';
import 'package:rezept_app/src/database/models/recipe.dart';


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
          IngredientsView(isarLinks: recipe.ingredients,),
          Text(recipe.description),
        ],
      ),
    );
  }
}

class IngredientsView extends StatelessWidget {
  final IsarLinks<IngredientWithAmount> isarLinks;
  const IngredientsView({super.key, required this.isarLinks});

  buildIngredients(List<IngredientWithAmount> ingredients) =>
      ingredients.map((e) => IngredientView(ingredient: e)).toList();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isarLinks.load(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        else if(snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Column(
          children: buildIngredients(snapshot.data),
        );
      }
    );
  }
}

class IngredientView extends StatefulWidget {
  final IngredientWithAmount ingredient;
  const IngredientView({super.key, required this.ingredient});

  @override
  State<IngredientView> createState() => _IngredientViewState();
}

class _IngredientViewState extends State<IngredientView> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.ingredient.ingredient.load(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        else if(snapshot.hasError) {
          return Text('${snapshot.error}');
        }
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
                '${widget.ingredient.amount}${widget.ingredient.unit} ${widget.ingredient.ingredient}',
                style: isChecked
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : const TextStyle()),
          ],
        );
      }
    );
  }
}
