import 'dart:async';

import 'package:isar/isar.dart';
import 'package:rezept_app/src/database/models/ingredient.dart';
import 'package:rezept_app/src/database/models/recipe.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveRecipe(Recipe newRecipe) async {
    final isar = await db;
    await isar.writeTxn<int>(() => isar.recipes.put(newRecipe));
  }

  Future<void> saveIngredient(Ingredient newIngredient) async {
    final isar = await db;
    await isar.writeTxn<int>(() => isar.ingredients.put(newIngredient));
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [IngredientSchema, RecipeSchema],
        directory: 'db',
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
