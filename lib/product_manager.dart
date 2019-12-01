import './product_control.dart';
import './products.dart';

import 'package:flutter/material.dart';

///
/// mange product list and add product button
///


class ProductManager extends StatelessWidget {

  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductManager(this.products, this.addProduct, this.deleteProduct);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ProductControl(addProduct),
          margin: EdgeInsets.all(8.0),
        ),
        Expanded(
          child: Products(
            products,
            deleteProduct: deleteProduct,
          ),
        ),
      ],
    );
  }
}
