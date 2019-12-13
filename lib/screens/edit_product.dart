import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );
  var _isNit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isNit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findByID(productId);

        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl
          'imageUrl': ''
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isNit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) &&
          (!_imageUrlController.text.endsWith('.jpg') &&
                  !_imageUrlController.text.endsWith('.png') ||
              !_imageUrlController.text.endsWith('.png'))) {
        return;
      }
      setState(() {});
    }
    // print();
  }

  void _saveForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
      Navigator.of(context).pop();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                return _saveForm();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues['title'],
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      title: value,
                      price: _editedProduct.price,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      id: _editedProduct.imageUrl,
                    );
                  },
                  validator: (value) => value.trim().length < 5
                      ? 'Please enter a valid title'
                      : null,
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  focusNode: _descriptionFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if (double.parse(value) <= 1) {
                      return 'Please enter an amount greater than 1';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      title: _editedProduct.title,
                      price: (double.parse(value)),
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      id: _editedProduct.imageUrl,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _initValues['description'],
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _priceFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a description";
                    }
                    if (value.length < 5) {
                      return 'Please a valid description';
                    }
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      title: _editedProduct.title,
                      price: _editedProduct.price,
                      description: value,
                      imageUrl: _editedProduct.imageUrl,
                      id: _editedProduct.imageUrl,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      margin: EdgeInsets.only(top: 8.0, right: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Please enter an imageURL')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _imageUrlController,
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        validator: (value) {
                          if (!value.startsWith('http') &&
                                  !value.startsWith('https') ||
                              !value.endsWith('.jpg') &
                                      !value.endsWith('.png') &&
                                  !value.endsWith('.jpeg')) {
                            return 'Please enter a valid image Url';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              description: _editedProduct.description,
                              imageUrl: value,
                              id: null);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
