import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_manager/models/models.dart';
import 'package:intl/intl.dart';

class DinnersTable extends StatelessWidget {
  final List<Dinner> availableDinners;
  final bool Function(Dinner) isSelected;
  final void Function(Dinner, bool) onSelectChanged;

  const DinnersTable({Key key, this.availableDinners, this.isSelected, this.onSelectChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];

    for (Dinner dinner in availableDinners) {
      rows.add(
        DataRow(
          selected: isSelected(dinner),
          onSelectChanged: (selected) => onSelectChanged(dinner, selected),
          cells: [
            DataCell(Text(dinner.name)),
            DataCell(Text(NumberFormat.simpleCurrency().format(dinner.price()))),
            DataCell(Text(dinner.ingredientListSummary())),
          ],
        ),
      );
    }

    return DataTable(
      showBottomBorder: true,
      showCheckboxColumn: true,
      columns: [
        DataColumn(label: Text("Name")),
        DataColumn(label: Text("Price")),
        DataColumn(
          label: Text("Ingredients"),
        ),
      ],
      rows: rows,
    );
  }
}
