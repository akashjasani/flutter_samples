import 'package:flutter/material.dart';
import '../screens/filter_screen.dart';
import '../screens/TabScreen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget _listTileWidget(String text, IconData icon, VoidCallback tapHandle) {
    return ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black
          ),
        ),
        onTap: tapHandle);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 90,
            color: Theme.of(context).accentColor,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 26,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _listTileWidget('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed(TabScreen.routName);
          }),
          _listTileWidget('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FilterScreen.routName);
          }),
        ],
      ),
    );
  }
}
