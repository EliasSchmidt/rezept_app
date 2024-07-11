import 'package:flutter/material.dart';
import 'package:rezept_app/src/database/models/ingredient.dart';

class AddIngredient extends StatefulWidget {
  const AddIngredient({super.key, required this.savedIngredients});
  final List<String> savedIngredients;

  @override
  State<AddIngredient> createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {

  List<Ingredient> _ingredients = [];
  TextEditingValue textEdetingValue = TextEditingValue();

  void _saveIngredient(Ingredient newIngredient){
    if(textEdetingValue.text == ''){return;}
    setState(() {
      _ingredients.add(newIngredient);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Autocomplete<String>(
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text == '') {
                    return const Iterable<String>.empty();
                  }
                  return widget.savedIngredients.where((String option) {
                    return option.contains(textEditingValue.text.toLowerCase());
                  });
                },
                fieldViewBuilder:
                    (context, textEditingController, focusNode, onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Zutat',
                    ),
                  );
                },
              ),
            ),
            IconButton(onPressed: () => _saveIngredient(Ingredient(name: textEdetingValue.text)), icon: const Icon(Icons.add), ),
          ],
        ),
        Expanded(child: ListView(children: _ingredients.map((ingredient) => Text(ingredient.name)).toList()))
      ],
    );
  }
}