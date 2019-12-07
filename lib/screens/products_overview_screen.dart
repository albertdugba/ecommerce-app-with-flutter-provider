import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilteredOption { Favourites, All }

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context, listen: false);
    var _showFavourites = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Amazon Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilteredOption selectedValue) {
              if (selectedValue == FilteredOption.Favourites) {
                productsContainer.showFavouritesOnly();
                _showFavourites = true;
              } else {
                productsContainer.showAll();
                _showFavourites = false;
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilteredOption.Favourites),
              PopupMenuItem(child: Text('Show All'), value: FilteredOption.All),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              child: child,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavourites),
    );
  }
}
