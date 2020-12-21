import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/blocs.dart';
import 'package:grocery_manager/models/lists.dart';
import 'package:grocery_manager/models/models.dart';
import 'package:intl/intl.dart';

class ShoppingTrackerView extends StatefulWidget {
  final GroceryList list;

  const ShoppingTrackerView({Key key, this.list}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ShoppingTrackerState();
}

class _ShoppingTrackerState extends State<ShoppingTrackerView> {
  List<GroceryListItem> _itemList;

  @override
  void initState() {
    super.initState();
    _itemList = widget.list.items;
    _itemList.sort((a, b) => a.aisle.compareTo(b.aisle));
  }

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
                child: createTable(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MaterialButton(
            child: Text("Cancel"),
            onPressed: () {
              BlocProvider.of<ListBloc>(context).add(ListCancelled());
            },
          ),
          Text("Current Total: ${NumberFormat.simpleCurrency().format(currentTotalPrice())}"),
          MaterialButton(
            child: Text("Save"),
            onPressed: () {
              BlocProvider.of<ListBloc>(context).add(
                ListShoppingFinished(widget.list.copyWith(items: _itemList)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget createTable() {
    List<DataRow> rows = [];

    for (int i = 0; i < _itemList.length; i++) {
      GroceryListItem item = _itemList[i];
      rows.add(
        DataRow(
          cells: [
            DataCell(Text(item.name)),
            DataCell(Text(NumberFormat.simpleCurrency().format(item.price))),
            DataCell(Text(item.abbreviatedAisle)),
            DataCell(
              Switch(
                value: item.purchased,
                onChanged: (value) {
                  setState(() {
                    _itemList[i] = item.copyWith(purchased: value);
                  });
                },
              ),
            ),
          ],
        ),
      );
    }

    return DataTable(
      sortColumnIndex: 2,
      columns: [
        DataColumn(label: Text("Name")),
        DataColumn(label: Text("Price")),
        DataColumn(label: Text("Aisle")),
        DataColumn(label: Text("Purchased")),
      ],
      rows: rows,
    );
  }

  double currentTotalPrice() {
    Iterable<GroceryListItem> itemsPurchased = _itemList.where((item) => item.purchased);

    if (itemsPurchased.isEmpty) {
      return 0;
    }

    return itemsPurchased.map((item) => item.price).reduce((value, element) => value + element);
  }
}
