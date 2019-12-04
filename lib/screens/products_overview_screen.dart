import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilteredOption { Favourites, All }

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Renegades Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilteredOption selectedValue) {
              if (selectedValue == FilteredOption.Favourites) {
                productsContainer.showFavouritesOnly();
              } else {
                productsContainer.showAll();
              }
              print('Selected $selectedValue');
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilteredOption.Favourites),
              PopupMenuItem(child: Text('Show All'), value: FilteredOption.All),
            ],
          )
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
