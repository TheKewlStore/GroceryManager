import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/list/list_bloc.dart';
import 'package:grocery_manager/widgets/lists/shopping_tracker.dart';
import 'package:grocery_manager/widgets/widgets.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        if (state is ShowingAllLists) {
          return GroceryListHistoricalView(
            lists: state.availableLists,
          );
        } else if (state is ShowingChecklist) {
          return Checklist(
            itemsToCheck: state.itemsToCheck,
            timeCreated: state.timeCreated,
          );
        } else if (state is SchedulingDinners) {
          return DinnerScheduler(
            availableDinners: state.availableDinners,
            currentItems: state.currentItems,
            timeCreated: state.timeCreated,
          );
        } else if (state is EditingList) {
          return ListEditor(
            availableItems: state.availableItems,
            currentItems: state.currentItems,
            timeCreated: state.timeCreated,
          );
        } else if (state is ListShopping) {
          return ShoppingTrackerView(list: state.list);
        } else if (state is ItemLoadingFailed) {
          return Center(child: Text("Item Loading Failed Page: ${state.error}"));
        } else {
          return Center(child: Text("Invalid State Encountered: ${state.runtimeType.toString()}"));
        }
      },
    );
  }
}
