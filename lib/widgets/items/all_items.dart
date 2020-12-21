import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/blocs.dart';
import 'package:grocery_manager/blocs/items/items_event.dart';
import 'package:grocery_manager/models/items.dart';
import 'package:grocery_manager/widgets/items/item_table.dart';

class AllItemsView extends StatefulWidget {
  final List<GroceryItem> items;

  const AllItemsView({Key key, this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AllItemsViewState();
}

class _AllItemsViewState extends State<AllItemsView> {
  List<GroceryItem> itemsToDelete = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: itemDataTable(
                  widget.items,
                  true,
                  isSelected: (item) => itemsToDelete.contains(item),
                  onSelectChanged: (selected, item) => setState(() {
                    if (selected) {
                      itemsToDelete.add(item);
                    } else {
                      itemsToDelete.remove(item);
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            maintainInteractivity: false,
            maintainSize: false,
            visible: itemsToDelete.isNotEmpty,
            child: MaterialButton(
              child: Text("Delete Selected"),
              onPressed: () {
                BlocProvider.of<ItemsBloc>(context).add(ItemsDeleted(items: itemsToDelete));
              },
            ),
          ),
          MaterialButton(
            child: Text("New"),
            onPressed: () {
              BlocProvider.of<ItemsBloc>(context).add(CreateNewItem());
            },
          ),
        ],
      ),
    );
  }
}
