import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_manager/blocs/blocs.dart';
import 'package:grocery_manager/database/database.dart';
import 'package:grocery_manager/repositories/repository.dart';
import 'package:grocery_manager/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GroceryManagerDatabase database = await $FloorGroceryManagerDatabase.databaseBuilder("grocery_manager.db").build();

  runApp(GroceryManagerApp(
    database: database,
  ));
}

class GroceryManagerApp extends StatelessWidget {
  final GroceryManagerDatabase database;

  GroceryManagerApp({Key key, this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ListBloc(repository: GroceryManagerRepository(database: database))),
        BlocProvider(create: (context) => ItemsBloc(repository: GroceryManagerRepository(database: database))),
        BlocProvider(create: (context) => DinnersBloc(repository: GroceryManagerRepository(database: database))),
      ],
      child: MaterialApp(
        title: 'Grocery Manager',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
