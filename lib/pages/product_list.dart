
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:easylist2/scoped-models/products.dart';

import 'product_edit.dart';

class ProductListPage extends StatelessWidget {
  
  Widget _buildEditButton(BuildContext context, int index, ProductModel model) {
    return IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            model.selectProduct(index);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => ProductEditPage(),
              ),
            );
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductModel>(builder: (BuildContext context, Widget child, ProductModel model){
      return ListView.builder(
      itemCount: model.products.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(model.products[index].title),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              print('end to start. product deleted');
              model.selectProduct(index);
              model.deleteProduct();
            } else if (direction == DismissDirection.startToEnd) {
              print('start to end');
            } else {
              print('other swipe');
            }
          },
          background: Container(
            color: Colors.red[900],
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        model.products[index].image,
                      ),
                    ),
                    title: Text(model.products[index].title),
                    subtitle: Text('\$${model.products[index].price}'),
                    trailing: _buildEditButton(context, index, model),
                  ),
                  Divider(
                    color: Colors.black26,
                    indent: 10.0,
                    endIndent: 10.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    },); 
  }
}
