import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/blocs.dart';
import 'package:grocery_manager/models/models.dart';
import 'package:grocery_manager/widgets/dinners/dinners_table.dart';

class DinnerScheduler extends StatefulWidget {
  final List<Dinner> availableDinners;
  final List<GroceryItem> currentItems;
  final DateTime timeCreated;

  DinnerScheduler({Key key, @required this.availableDinners, @required this.currentItems, @required this.timeCreated}) : super(key: key);

  @override
  _DinnerSchedulerState createState() => _DinnerSchedulerState();
}

class _DinnerSchedulerState extends State<DinnerScheduler> {
  List<Dinner> dinnersScheduled = [];

  @override
  void initState() {
    super.initState();

    if (widget.availableDinners.isEmpty) {
      BlocProvider.of<ListBloc>(context).add(
        DinnerScheduleConfirmed(
          dinnersScheduled: [],
          currentItems: widget.currentItems,
          timeCreated: widget.timeCreated,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DinnersTable(
          availableDinners: widget.availableDinners,
          isSelected: (dinner) => dinnersScheduled.contains(dinner),
          onSelectChanged: (dinner, selected) {
            setState(() {
              if (!selected) {
                dinnersScheduled.remove(dinner);
              } else {
                dinnersScheduled.add(dinner);
              }
            });
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
            child: Text("Next"),
            onPressed: () {
              BlocProvider.of<ListBloc>(context).add(
                DinnerScheduleConfirmed(
                  dinnersScheduled: dinnersScheduled,
                  currentItems: widget.currentItems,
                  timeCreated: widget.timeCreated,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
