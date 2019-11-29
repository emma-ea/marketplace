import 'package:easylist2/product_control.dart';
import 'package:easylist2/products.dart';
import 'package:flutter/material.dart';

class ProductManager extends StatefulWidget {
  final Map<String, String> startingProduct;
  ProductManager({this.startingProduct});

  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, String>> _products = [];

  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ProductControl(_addProduct),
          margin: EdgeInsets.all(8.0),
        ),
        Expanded(
          child: Products(_products),
        ),
      ],
    );
  }
}
