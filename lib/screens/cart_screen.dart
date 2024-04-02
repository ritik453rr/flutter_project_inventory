import 'package:flutter/material.dart';
import 'package:kitchen_app/provider/cart.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) =>  Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total:${cart.total}'),
              Text('Item Count:${cart.itemCount}'),
            ],
          ),
        ),
      ),
    );
  }
}
