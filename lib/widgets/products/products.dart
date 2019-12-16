import 'package:easylist2/widgets/products/product_card.dart';
import 'package:flutter/material.dart';

import 'price_tag.dart';

///
/// hold a list of products.. displayed in products.dart ProductsPage
///

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products);

  Widget _buildProductList() {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) => ProductCard(
          index: index,
          product: products[index],
        ),
      );
    } else {
      productCards = Center(
        child: Text('No Products Found.'),
      );
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}
