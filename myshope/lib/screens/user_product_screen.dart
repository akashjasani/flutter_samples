import 'package:flutter/material.dart';
import 'package:myshope/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routName = 'user_product_screen';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) => Column(children: [
            UserProductItem(
                id: products.items[index].id,
                title: products.items[index].title,
                imageUrl: products.items[index].imageUrl),
            const Divider(),
          ]),
          itemCount: products.items.length,
        ),
      ),
    );
  }
}
