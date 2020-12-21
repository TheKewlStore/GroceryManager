import 'package:flutter/material.dart';
import 'package:grocery_manager/screens/dinners.dart';
import 'package:grocery_manager/screens/items.dart';
import 'package:grocery_manager/screens/lists.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget groceryListScreen;
  Widget itemsListScreen = Center(child: Text("Items List Screen"));
  Widget dinnersListScreen = Center(child: Text("Dinners List Screen"));
  Widget currentScreen;

  @override
  void initState() {
    super.initState();
    currentScreen = groceryListScreen;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Grocery Manager"),
          bottom: TabBar(
            tabs: [
              Icon(Icons.list),
              Icon(Icons.shopping_bag),
              Icon(Icons.fastfood),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GroceryListScreen(),
            GroceryItemsScreen(),
            GroceryDinnersScreen(),
          ],
        ),
      ),
    );
  }
}
