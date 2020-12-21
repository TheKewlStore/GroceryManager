import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/dinners/dinners_bloc.dart';
import 'package:grocery_manager/widgets/dinners/add_edit_dinner.dart';
import 'package:grocery_manager/widgets/dinners/all_dinners.dart';

class GroceryDinnersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DinnersBloc, DinnerState>(
      builder: (context, state) {
        if (state is LoadingDinners) {
          return CircularProgressIndicator(value: null);
        } else if (state is ViewingAllDinners) {
          return AllDinnersView(availableDinners: state.availableDinners);
        } else if (state is CreatingDinner) {
          return AddEditDinnerView(
            availableItems: state.availableItems,
          );
        } else if (state is EditingDinner) {
          return AddEditDinnerView(
            dinner: state.dinner,
            availableItems: state.availableItems,
          );
        } else {
          return Center(
            child: Text("Unknown Dinner Bloc State $state}"),
          );
        }
      },
    );
  }
}
