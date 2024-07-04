import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:rezept_app/src/database/models/ingredient.dart';

class NewRecipeView extends StatelessWidget {
  NewRecipeView({super.key, required this.isar});
  final Isar isar;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


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
            const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Name',
          ),
          maxLength: 24,
          ),
          const TextField(
           decoration: InputDecoration(
             border: OutlineInputBorder(),
             labelText: 'Kurzbeschreibung',
           ),
           maxLines: 2,
           maxLength: 48,),
           FutureBuilder(
             future: isar.ingredients.where().findAll(),
             builder: (context, snapshot) {
               if(snapshot.connectionState == ConnectionState.done){
                 if(snapshot.hasData){
                   List<Ingredient> ingredients = snapshot.data as List<Ingredient>;
                   return Expanded(child: CustomAutoComplete(options: ingredients.map((e) => e.name).toList()));
                 }
                 else if(snapshot.hasError){
                   return Text(snapshot.error.toString());
                 }
               }
               return const CircularProgressIndicator();
             }
           ),
           ElevatedButton(onPressed: () {
            if (_formKey.currentState!.validate()) {
                  isar.txn(callback: (isar) async {
                    Ingredient ingredient = Ingredient();
                    ingredient.name = _formKey.currentState!.fields['name']?.value as String;
                    ingredient.description = _formKey.currentState!.fields['description']?.value as String;
                    ingredient.ingredients = _formKey.currentState!.fields['ingredients']?.value as String;
                    await isar.ingredients.put(ingredient);
                  })
                }}, child: const Text('Hinzufügen'),)
           ],
        ),
      ),
    );
  }
}

class CustomAutoComplete extends StatelessWidget {
  const CustomAutoComplete({super.key, required this.options});
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return options.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Zutat',
          ),
        );
      },
    );
  }
}

