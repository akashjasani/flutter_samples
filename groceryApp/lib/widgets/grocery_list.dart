import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/categories.dart';
import '../models/grocery_item.dart';
import './new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isloading = true;
  var _errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    _loadItems();
    super.initState();
  }

  void _loadItems() async {
    try {
      final url = Uri.https('flutterdemo-31d6a-default-rtdb.firebaseio.com',
          'shopping-list.json');
      final response = await http.get(url);
      if (response.statusCode != 200) {
        setState(() {
          _errorMessage = 'failed to fetch data. Please try again later';
        });
      }
      if (response.body == 'null') {
        setState(() {
          _isloading = false;
          return;
        });
      }
      final Map<String, dynamic> listdata = json.decode(response.body);
      final List<GroceryItem> _loadedItemList = [];
      for (final item in listdata.entries) {
        final category = categories.entries
            .firstWhere(
                (element) => element.value.title == item.value['category'])
            .value;
        _loadedItemList.add(GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category));
      }
      setState(() {
        _groceryItems = _loadedItemList;
        _isloading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'failed to fetch data. Please try again later';
        _isloading = false;
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  Future<void> _removeItem(GroceryItem item) async {
    final url = Uri.https('flutterdemo-31d6a-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    http.delete(url);

    setState(() {
      _groceryItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));
    if (_isloading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }

    if (_errorMessage.isNotEmpty) {
      content = Center(child: Text(_errorMessage));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
