import 'package:flutter/material.dart';
import 'package:grocery_manager/date_time_utils.dart';
import 'package:grocery_manager/models/models.dart';
import 'package:intl/intl.dart';

class EditListMockup extends StatefulWidget {
  final List<GroceryItem> availableItems;
  final List<GroceryItem> currentItems;
  final DateTime dateTime;

  const EditListMockup({Key key, this.availableItems, this.currentItems, this.dateTime}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditListMockupState();
}

class _EditListMockupState extends State<EditListMockup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Grocery List (${formatDate(widget.dateTime)})"),
      ),
      body: ListView.builder(
        itemCount: widget.currentItems.length,
        itemBuilder: (context, index) {
          GroceryItem item;

          if (index < widget.currentItems.length) {
            item = widget.currentItems[index];
          }

          return ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text(item?.name),
            subtitle: Text(NumberFormat.currency().format(item != null ? item.price : 0)),
          );
        },
      ),
      bottomNavigationBar: Row(
        children: [
          MaterialButton(
            child: Text("Add Item"),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Container();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
