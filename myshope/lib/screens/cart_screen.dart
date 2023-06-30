import 'package:flutter/material.dart';
import 'package:myshope/providers/orders.dart';
import '../providers/CartProvider.dart';
import '../widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routName = 'cart_screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 20),
                ),
                const Spacer(),
                Chip(
                  label: Text("\$${cart.totalAmount.toStringAsPrecision(2)}",
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleLarge
                              ?.color)),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.item.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                    child: const Text("ORDER NOW"))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: cart.item.length,
              itemBuilder: (context, index) {
                return CartItemWidget(
                    cart.item.values.toList()[index].id,
                    cart.item.keys.toList()[index],
                    cart.item.values.toList()[index].price,
                    cart.item.values.toList()[index].quantity,
                    cart.item.values.toList()[index].title);
              }),
        )
      ]),
    );
  }
}
