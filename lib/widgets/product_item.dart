import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GestureDetector(
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
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);

                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Icon(Icons.check_circle),
                        SizedBox(width: 6.0),
                        Text(
                          '${product.title} has been added to cart',
                          softWrap: true,
                        )
                      ],
                    ),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.teal,
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {},
                    ),
                  ),
                );
              },
              icon: Icon(Icons.shopping_basket),
            ),
          ),
        ),
      ),
    );
  }
}
