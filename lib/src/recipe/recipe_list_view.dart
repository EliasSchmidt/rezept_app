import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:rezept_app/src/database/models/recipe.dart';
import 'package:rezept_app/src/recipe/new_recipe_view.dart';
import 'package:rezept_app/src/recipe/recipe_view.dart';

class RecipeListView extends StatelessWidget {
  static const String routeName = '/RecipeListView';
  const RecipeListView({super.key, required this.isar});

  final Isar isar;

  Future<List<Recipe>> loadRecipes() async {
    return isar.recipes.where().findAll();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rezepte'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  NewRecipeView(isar: isar))),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: loadRecipes(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              List<Recipe> recipes = snapshot.data as List<Recipe>;
              return ListView.separated(
                itemCount: recipes.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return RecepieListItem(recipe: recipes[index]);
                }
              );
            }
            else if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
          }
          return const Center(child: CircularProgressIndicator());
          }
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
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeView(
                      recipe: recipe,
                    )));
      },
      child: Row(
        children: [
          Ink.image(
              image: Image.asset(recipe.imageUri).image, height: 80, width: 80),
          const SizedBox(width: 10),
          Text(recipe.title),
        ],
      ),
    );
  }
}
