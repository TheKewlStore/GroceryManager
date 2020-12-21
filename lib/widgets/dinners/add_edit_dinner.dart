import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:grocery_manager/blocs/blocs.dart';
import 'package:grocery_manager/models/models.dart';
import 'package:grocery_manager/widgets/items/item_table.dart';
import 'package:intl/intl.dart';

class AddEditDinnerView extends StatefulWidget {
  final Dinner dinner;
  final List<GroceryItem> availableItems;

  const AddEditDinnerView({Key key, this.dinner, @required this.availableItems}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddEditDinnerState();
}

class _AddEditDinnerState extends State<AddEditDinnerView> {
  final _formKey = GlobalKey<FormState>();
  int id;
  String name;
  List<GroceryItem> ingredients;

  @override
  void initState() {
    super.initState();

    if (widget.dinner != null) {
      id = widget.dinner.id;
      name = widget.dinner.name;
      ingredients = widget.dinner.ingredients;
    } else {
      ingredients = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                // Dinner Name
                initialValue: name,
                decoration: InputDecoration(
                  icon: Icon(Icons.edit),
                  hintText: "Spaghetti",
                  labelText: "Dinner Name",
                ),
                validator: (value) {
                  GroceryItem item = widget.availableItems.firstWhere(
                    (item) => item.name == value,
                    orElse: () => null,
                  );
                  if (item != null) {
                    return "Existing Grocery Item with same name!";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  name = value;
                },
              ),
              SingleChildScrollView(
                child: itemDataTable(ingredients, false),
              ),
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    icon: Icon(Icons.add),
                    hintText: "Eggs",
                    labelText: "Add Item",
                  ),
                  onSubmitted: (value) {
                    onGroceryItemAdded(
                      widget.availableItems.firstWhere(
                        (element) => element.name == value,
                        orElse: () => null,
                      ),
                    );
                  },
                ),
                suggestionsCallback: (pattern) async {
                  return widget.availableItems.where((element) => element.name.contains(pattern) && !ingredients.contains(element));
                },
                itemBuilder: (context, GroceryItem suggestion) {
                  return ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text(suggestion.name),
                    subtitle: Text(NumberFormat.simpleCurrency().format(suggestion.price)),
                  );
                },
                onSuggestionSelected: (GroceryItem suggestion) {
                  onGroceryItemAdded(suggestion);
                },
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    child: Text("Save"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        BlocProvider.of<DinnersBloc>(context).add(
                          DinnerSaved(
                            dinner: Dinner(name: name, ingredients: ingredients),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onGroceryItemAdded(GroceryItem item) {
    if (item == null) {
      return;
    }

    setState(() {
      if (!ingredients.contains(item)) {
        ingredients.add(item);
      }
    });
  }
}
