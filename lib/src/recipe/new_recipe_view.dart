import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:rezept_app/src/database/models/ingredient.dart';
import 'package:rezept_app/src/database/models/recipe.dart';
import 'package:rezept_app/src/recipe/add_ingredient.dart';

class NewRecipeView extends StatefulWidget {
  const NewRecipeView({super.key, required this.isar});
  final Isar isar;

  @override
  State<NewRecipeView> createState() => _NewRecipeViewState();
}

class _NewRecipeViewState extends State<NewRecipeView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name;
  String? _shortDescription;
  String? _description;
  String? _imageUri;

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Recipe newRecipe = Recipe(
        description: _description!,
        shortDescription: _shortDescription!,
        title: _name!,
      );

      if (_imageUri != null) {
        newRecipe.imageUri = _imageUri!;
      }

      await widget.isar.writeTxn<int>(() => widget.isar.recipes.put(newRecipe));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neues Rezept'),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              maxLength: 24,
              onSaved: (newValue) => _name = newValue,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte geben Sie den Namen des Rezepts ein';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Kurzbeschreibung',
              ),
              maxLines: 2,
              maxLength: 48,
              onSaved: (newValue) => _shortDescription = newValue,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte geben Sie eine Kurzbeschreibung des Rezepts(Spaghetti Carbonara: Spagetti mit Schinken, Ei und Parmesan) ein';
                }
                return null;
              },
            ),
            FutureBuilder(
                future: widget.isar.ingredients.where().findAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<Ingredient> ingredients =
                          snapshot.data as List<Ingredient>;
                      return Expanded(
                          child: AddIngredient(
                              savedIngredients:
                                  ingredients.map((e) => e.name).toList()));
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                  }
                  return const CircularProgressIndicator();
                }),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Beschreibung',
              ),
              onSaved: (newValue) => _description = newValue,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte geben Sie den Rezepttext ein';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _saveRecipe();
                }
              },
              child: const Text('Hinzufügen'),
            )
          ],
        ),
      ),
    );
  }
}


