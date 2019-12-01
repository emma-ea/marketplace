import './products.dart';

import 'package:flutter/material.dart';

///
/// mange product list and add product button
///


class ProductManager extends StatelessWidget {

  final List<Map<String, dynamic>> products;
  

  ProductManager(this.products);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Products(
            products,
          ),
        ),
      ],
    );
  }
}
