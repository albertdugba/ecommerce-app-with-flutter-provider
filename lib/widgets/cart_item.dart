import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productID;
  final double price;
  final int quantity;
  final String title;

  CartItem({this.id, this.productID, this.price, this.quantity, this.title});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(this.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40.0,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 4.0,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child:
                  FittedBox(child: Text('\$${this.price.toStringAsFixed(1)}')),
            ),
            title: Text(this.title),
            subtitle: Text('Total is \$${(this.price * this.quantity)}'),
            trailing:
                Text('${this.quantity} x ${this.price.toStringAsFixed(2)}'),
          ),
        ),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context).removeCartItem(productID);
      },
    );
  }
}
