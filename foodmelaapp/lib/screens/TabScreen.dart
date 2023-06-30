import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './category_screen.dart';

class TabScreen extends StatefulWidget {
  static const routName = "TabScreen";

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Map<String, Object>> _page = [
    {'page': Category(), 'title': 'Category'},
    {'page': FavoritesScreen(), 'title': 'Favorites'}
  ].toList();
  int _pageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page[_pageIndex]['title'] as String),
      ),
      body: _page[_pageIndex]['page'] as Widget,
      drawer: const MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => _selectPage(index),
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.category),
              label: 'Category',
              backgroundColor: Theme.of(context).primaryColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.star),
              label: 'Favorites',
              backgroundColor: Theme.of(context).primaryColor,
            )
          ]),
    );
  }
}
