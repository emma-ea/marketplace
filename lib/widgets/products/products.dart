import 'package:easylist2/models/product.dart';
import 'package:easylist2/scoped-models/main.dart';
import 'package:easylist2/widgets/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


///
/// hold a list of products.. displayed in products.dart ProductsPage
///

class Products extends StatelessWidget {
 
  Widget _buildProductList(List<Product> products) {
    Widget productCards;
    if (products.length > 0) {
      productCards = ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) => ProductCard(
          productIndex: index,
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
    return ScopedModelDescendant <MainModel>(builder: (BuildContext context, Widget child, MainModel model){
      return _buildProductList(model.displayProducts);
    },);
  }
}
