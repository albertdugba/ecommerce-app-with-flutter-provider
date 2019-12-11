import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import '../providers/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routName = '/product-details';
  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context).settings.arguments as String;
    final cart = Provider.of<Cart>(context);
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findByID(productID);

    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300.0,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '\GHC${loadedProduct.price}',
              style: TextStyle(color: Colors.grey, fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              width: double.infinity,
              child: Text(loadedProduct.description,
                  textAlign: TextAlign.center, softWrap: true),
            ),
            RaisedButton(
              child: Text('Buy Now'),
              onPressed: () {
                cart.addItem(
                    loadedProduct.id, loadedProduct.price, loadedProduct.title);
                // Scaffold.of(context).showSnackBar(SnackBar(
                //   content: Text('Added has been added to cart'),
                // ));
              },
            )
          ],
        ),
      ),
    );
  }
}
