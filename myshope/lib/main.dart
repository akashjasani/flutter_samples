import 'package:flutter/material.dart';
import 'package:myshope/screens/edit_product_screen.dart';
import 'package:myshope/screens/user_product_screen.dart';
import './screens/orders_screen.dart';
import '../providers/orders.dart';
import './screens/cart_screen.dart';
import './providers/CartProvider.dart';
import 'package:provider/provider.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';
import './providers/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => Orders())
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.purple, hintColor: Colors.deepOrange),
        home: ProductOverviewScreen(),
        routes: {
          OrdersScreen.routName: (context) => OrdersScreen(),
          ProductDetailScreen.routName: (context) =>
              const ProductDetailScreen(),
          CartScreen.routName: (context) => CartScreen(),
          UserProductScreen.routName: (context) => UserProductScreen(),
          EditProductScreen.routName: (context) => EditProductScreen()
        },
      ),
    );
  }
}
