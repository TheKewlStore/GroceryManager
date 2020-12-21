import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/blocs.dart';
import 'package:grocery_manager/date_time_utils.dart';
import 'package:grocery_manager/models/models.dart';
import 'package:intl/intl.dart';

class GroceryListHistoricalView extends StatelessWidget {
  final List<GroceryList> lists;

  const GroceryListHistoricalView({Key key, this.lists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: lists.length,
        itemBuilder: (context, index) {
          GroceryList list = lists[index];
          return ListTile(
            title: Text("${formatDateTime(list.timeCreated)}"),
            subtitle: Text("Total Cost: ${NumberFormat.simpleCurrency().format(list.totalPrice())} - Spent: ${NumberFormat.simpleCurrency().format(list.spentPrice())}"),
            onTap: () {
              BlocProvider.of<ListBloc>(context).add(ListShoppingStarted(list));
            },
          );
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MaterialButton(
            child: Text("Start List for ${formatDate(DateTime.now())}"),
            onPressed: () {
              BlocProvider.of<ListBloc>(context).add(NewListStarted(timeCreated: DateTime.now()));
            },
          ),
        ],
      ),
    );
  }
}
