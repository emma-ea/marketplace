import 'package:easylist2/products.dart';
import 'package:flutter/material.dart';

class ProductManager extends StatefulWidget {

  final String startingProduct;
  ProductManager({this.startingProduct = 'Sweets Tester'});

  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {

  List<String> _products = [];

  @override
  void initState() {
    super.initState();
    _products.add(widget.startingProduct);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
          children: [
            Container(
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('Add Product'),
                onPressed: () {
                  setState(() {
                    _products.add('Advanced Food Tester');
                  });
                },
              ),
              margin: EdgeInsets.all(8.0),
            ),
            Products(_products),
          ],
        );
  }
}