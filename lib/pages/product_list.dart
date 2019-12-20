
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:easylist2/scoped-models/main.dart';

import 'product_edit.dart';

class ProductListPage extends StatelessWidget {
  
  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
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
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
      return ListView.builder(
      itemCount: model.allProducts.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(model.allProducts[index].title),
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
                      backgroundImage: NetworkImage(
                        model.allProducts[index].image,
                      ),
                    ),
                    title: Text(model.allProducts[index].title),
                    subtitle: Text('\$${model.allProducts[index].price}'),
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
