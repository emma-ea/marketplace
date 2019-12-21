import 'package:easylist2/models/product.dart';
import 'package:easylist2/widgets/products/address_tag.dart';
import 'package:easylist2/widgets/ui_elements/title_default.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:easylist2/scoped-models/main.dart';

import 'price_tag.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard({this.product, this.productIndex});

  Widget _buildTitlePriceRow() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleDefault(
            title: product.title,
          ),
          SizedBox(
            width: 6.0,
          ),
          PriceTag(
            price: product.price.toString(),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: 10.0,
      ),
    );
  }

  Widget _buildActionButtons(context) {
    return ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.info,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.pushNamed<bool>(
                context, '/product/' + model.allProducts[productIndex].id);
          },
        ),
        IconButton(
              icon: Icon(
                model.allProducts[productIndex].isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                model.selectProduct(model.allProducts[productIndex].id);
                model.toggleProductFavoriteStatus();
              },
        ),
      ],
    );});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(product.image),
            placeholder: AssetImage('assets/images/food.jpg'),
            height: 300.0,
            fit: BoxFit.cover,
          ),
          _buildTitlePriceRow(),
          AddressTag('Union Square Sans Francisco'),
          Text(product.userEmail),
          _buildActionButtons(context),
        ],
      ),
    );
  }
}
