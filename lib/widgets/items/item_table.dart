import 'package:flutter/material.dart';
import 'package:grocery_manager/models/models.dart';
import 'package:intl/intl.dart';

Widget itemDataTable(
  List<GroceryItem> items,
  bool showCheckboxColumn, {
  bool isSelected(GroceryItem item),
  onSelectChanged(bool selected, GroceryItem item),
}) {
  if (isSelected == null) {
    isSelected = (item) => false;
  }

  if (onSelectChanged == null) {
    onSelectChanged = (selected, item) => null;
  }

  List<DataRow> rows = [];

  for (GroceryItem item in items) {
    rows.add(
      DataRow(
        selected: isSelected(item),
        onSelectChanged: (selected) => onSelectChanged(selected, item),
        cells: [
          DataCell(Text(item.name)),
          DataCell(Text(NumberFormat.simpleCurrency().format(item.price))),
          DataCell(Text(item.aisle)),
          DataCell(Center(child: Checkbox(value: item.neededWeekly, onChanged: null))),
        ],
      ),
    );
  }

  return DataTable(
    showBottomBorder: true,
    showCheckboxColumn: showCheckboxColumn,
    columns: [
      DataColumn(label: Text("Name")),
      DataColumn(label: Text("Price")),
      DataColumn(label: Text("Aisle")),
      DataColumn(label: Text("Checklist")),
    ],
    rows: rows,
  );
}
