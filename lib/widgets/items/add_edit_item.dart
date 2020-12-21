import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/items/items_bloc.dart';
import 'package:grocery_manager/models/models.dart';

class AddEditItemView extends StatefulWidget {
  final GroceryItem item;

  AddEditItemView({Key key, this.item}) : super(key: key);

  @override
  _AddEditItemViewState createState() => _AddEditItemViewState();
}

class _AddEditItemViewState extends State<AddEditItemView> {
  final _formKey = GlobalKey<FormState>();
  int id;
  bool neededWeekly = false;
  String name;
  String aisle;
  double price;

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      id = widget.item.id;
      name = widget.item.name;
      aisle = widget.item.aisle;
      price = widget.item.price;
      neededWeekly = widget.item.neededWeekly;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                // Item Name
                initialValue: name,
                decoration: InputDecoration(
                  icon: Icon(Icons.edit),
                  hintText: "Bread",
                  labelText: "Item Name",
                ),
                onSaved: (value) {
                  name = value;
                },
              ),
              TextFormField(
                // Item Aisle
                initialValue: aisle,
                decoration: InputDecoration(
                  icon: Icon(Icons.shopping_bag),
                  hintText: "Bread/Cereal Aisle",
                  labelText: "In Store Location",
                ),
                onSaved: (value) {
                  aisle = value;
                },
              ),
              TextFormField(
                // Item Price
                initialValue: price != null ? price.toString() : "",
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  hintText: "1.99",
                  labelText: "Item Price",
                  prefixText: "\$",
                ),
                validator: (value) {
                  double parsedValue = double.tryParse(value);

                  if (parsedValue == null) {
                    return "Invalid decimal format for value";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  price = double.parse(value);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.repeat),
                  Text("Ask on checklist"),
                  MaterialButton(
                    color: neededWeekly ? Colors.lightBlueAccent : null,
                    onPressed: () {
                      setState(() {
                        neededWeekly = true;
                      });
                    },
                    child: Text("Yes"),
                  ),
                  MaterialButton(
                    child: Text("No"),
                    color: neededWeekly ? null : Colors.lightBlueAccent,
                    onPressed: () {
                      setState(() {
                        neededWeekly = false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MaterialButton(
            child: Text("Cancel"),
            onPressed: () {
              BlocProvider.of<ItemsBloc>(context).add(ItemCancelled());
            },
          ),
          MaterialButton(
            child: Text("Save"),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                GroceryItem newItem;

                if (widget.item != null) {
                  newItem = widget.item.copyWith(
                    name: this.name,
                    aisle: this.aisle,
                    price: this.price,
                    neededWeekly: this.neededWeekly,
                  );
                } else {
                  newItem = GroceryItem(
                    name: this.name,
                    aisle: this.aisle,
                    price: this.price,
                    neededWeekly: this.neededWeekly,
                  );
                }

                BlocProvider.of<ItemsBloc>(context).add(ItemSaved(newItem));
              }
            },
          ),
        ],
      ),
    );
  }
}
