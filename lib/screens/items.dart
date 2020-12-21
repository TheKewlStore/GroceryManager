import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/blocs.dart';
import 'package:grocery_manager/blocs/items/items_state.dart';
import 'package:grocery_manager/widgets/items/add_edit_item.dart';
import 'package:grocery_manager/widgets/items/all_items.dart';

class GroceryItemsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {
        if (state is LoadingItemsState) {
          return Center(child: CircularProgressIndicator(value: null));
        } else if (state is ViewingItemsState) {
          return AllItemsView(items: state.availableItems);
        } else if (state is CreatingItemState) {
          return AddEditItemView();
        } else if (state is EditingItemState) {
          return AddEditItemView(item: state.item);
        } else if (state is DeletingItemState) {
          return Center(child: CircularProgressIndicator(value: null));
        } else {
          return Center(child: Text("Unknown ItemsBloc State $state}"));
        }
      },
    );
  }
}
