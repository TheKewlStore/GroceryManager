import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/blocs.dart';
import 'package:grocery_manager/models/models.dart';
import 'package:grocery_manager/widgets/dinners/dinners_table.dart';

class AllDinnersView extends StatefulWidget {
  final List<Dinner> availableDinners;

  const AllDinnersView({Key key, this.availableDinners}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AllDinnersState();
}

class _AllDinnersState extends State<AllDinnersView> {
  List<Dinner> dinnersToDelete = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DinnersTable(
              availableDinners: widget.availableDinners,
              isSelected: (dinner) => dinnersToDelete.contains(dinner),
              onSelectChanged: null,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            child: Text("New"),
            onPressed: () {
              BlocProvider.of<DinnersBloc>(context).add(NewDinnerStarted());
            },
          ),
          MaterialButton(
            child: Text("Import from CSV"),
            onPressed: () async {
              FilePickerResult result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ["csv"],
              );

              if (result != null) {
                BlocProvider.of<DinnersBloc>(context).add(DinnersImported(file: File(result.files.single.path)));
              }
            },
          ),
        ],
      ),
    );
  }
}
