import 'package:easylist2/widgets/products/address_tag.dart';
import 'package:easylist2/widgets/ui_elements/title_default.dart';
import 'package:flutter/material.dart';

import 'price_tag.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int index;

  ProductCard({this.product, this.index});

  Widget _buildTitlePriceRow() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleDefault(
            title: product['title'],
          ),
          SizedBox(width: 6.0,),
          PriceTag(
            price: product['price'].toString(),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: 10.0,
      ),
    );
  }

  Widget _buildActionButtons(context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.info,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.pushNamed<bool>(context, '/product/' + index.toString());
          },
        ),
        IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product['image']),
          _buildTitlePriceRow(),
          AddressTag('Union Square Sans Francisco'),
          _buildActionButtons(context),
        ],
      ),
    );
    ;
  }
}
