import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // // final double price;

  // ProductItem(
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  // );
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routName, arguments: product.id),
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (context, product, _) => IconButton(
                color: Theme.of(context).accentColor,
                onPressed: () {
                  product.toggleFavouriteStatus();
                },
                icon: Icon(product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border),
              ),
            ),
            backgroundColor: Colors.black26,
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              color: Theme.of(context).accentColor,
              onPressed: () => print('Shopping cart...'),
              icon: Icon(Icons.shopping_basket),
            ),
          ),
        ),
      ),
    );
  }
}
