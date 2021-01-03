import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/blocs.dart';
import 'package:grocery_manager/models/models.dart';
import 'package:grocery_manager/widgets/items/lookup_item_bar.dart';
import 'package:intl/intl.dart';

class ListEditor extends StatefulWidget {
  final List<GroceryItem> availableItems;
  final List<GroceryItem> currentItems;
  final DateTime timeCreated;

  ListEditor({Key key, @required this.availableItems, @required this.currentItems, @required this.timeCreated}) : super(key: key);

  @override
  _ListEditorState createState() => _ListEditorState();
}

class _ListEditorState extends State<ListEditor> {
  List<GroceryItem> listItems;

  @override
  void initState() {
    super.initState();
    listItems = widget.currentItems;
  }

  void onGroceryItemAdded(GroceryItem item) {
    if (item == null || listItems.contains(item)) {
      return;
    }

    setState(() {
      listItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            Expanded(child: itemsList()),
            Spacer(),
            lookupItemBar(onGroceryItemAdded, widget.availableItems, listItems),
          ],
        ),
      ),
      bottomNavigationBar: bottomBar(),
    );
  }

  Widget itemsList() {
    return ListView.builder(
      itemCount: listItems.length,
      itemBuilder: (context, index) {
        GroceryItem item = listItems[index];

        return Row(
          children: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  if (listItems[index] == item) {
                    listItems.removeAt(index);
                  }
                });
              },
            ),
            Text("${item.name}", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 10),
            Text(
              "${NumberFormat.simpleCurrency().format(item.price)}",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            ),
          ],
        );
      },
    );
  }

  Widget bottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
          child: Text("Cancel"),
          onPressed: () {
            BlocProvider.of<ListBloc>(context).add(ListCancelled());
          },
        ),
        MaterialButton(
          child: Text("Save"),
          onPressed: () {
            BlocProvider.of<ListBloc>(context).add(
              ListSaved(items: listItems, timeCreated: widget.timeCreated),
            );
          },
        )
      ],
    );
  }
}
