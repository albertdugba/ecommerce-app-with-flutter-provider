import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(width: 10.0),
                  Chip(
                    label: Text('\$${cart.totalAmount}'),
                    backgroundColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
