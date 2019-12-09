import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 9.0,
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Ghana Amazon'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('Shop'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.pushReplacementNamed(context, OrdersScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
