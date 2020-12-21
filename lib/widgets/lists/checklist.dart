import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/blocs.dart';
import 'package:grocery_manager/models/models.dart';

class Checklist extends StatefulWidget {
  final List<GroceryItem> itemsToCheck;
  final DateTime timeCreated;

  Checklist({Key key, this.itemsToCheck, this.timeCreated}) : super(key: key);

  @override
  _ChecklistState createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  Map<GroceryItem, bool> itemsNeeded = {};

  @override
  void initState() {
    super.initState();

    for (GroceryItem item in widget.itemsToCheck) {
      itemsNeeded[item] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: checklist(),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
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
              List<GroceryItem> items = itemsNeeded.entries.where((element) => element.value).map((e) => e.key).toList();
              BlocProvider.of<ListBloc>(context).add(ChecklistConfirmed(itemsChecked: items, timeCreated: widget.timeCreated));
            },
          )
        ],
      ),
    );
  }

  Widget checklist() {
    return ListView.builder(
      itemCount: widget.itemsToCheck.length,
      itemBuilder: (context, index) {
        GroceryItem item;

        bool yesSelected = false;

        if (index < widget.itemsToCheck.length) {
          item = widget.itemsToCheck[index];
          yesSelected = itemsNeeded[item];
        } else {
          item = null;
          yesSelected = false;
        }

        if (yesSelected == null) {
          yesSelected = false;
        }

        return Container(
          padding: EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do you need ${item.name} today?",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: yesSelected ? Colors.lightBlueAccent : null,
                    onPressed: () {
                      setState(() {
                        itemsNeeded[item] = true;
                      });
                    },
                    child: Text("Yes"),
                  ),
                  MaterialButton(
                    child: Text("No"),
                    color: yesSelected ? null : Colors.lightBlueAccent,
                    onPressed: () {
                      setState(() {
                        itemsNeeded[item] = false;
                      });
                    },
                  ),
                ],
              ),
              Center(
                child: Divider(thickness: 4.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
