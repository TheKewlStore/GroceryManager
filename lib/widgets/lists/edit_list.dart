import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/blocs.dart';
import 'package:grocery_manager/models/models.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        child: ListView.builder(
          itemCount: listItems.length,
          itemBuilder: (context, index) {
            GroceryItem item = listItems[index];

            return Row(
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
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
        ),
      ),
      bottomNavigationBar: Row(
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
      ),
    );
  }
}
