import 'package:easylist2/models/product.dart';
import 'package:easylist2/scoped-models/products.dart';
import 'package:easylist2/widgets/products/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// add new products page
///

class ProductsPage extends StatelessWidget {
  
  Widget _buildSideDrawer(context) {
    return Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              title: Text('Choose'),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Manage Products'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            ),
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('Marketplace'),
        actions: <Widget>[
          ScopedModelDescendant<ProductModel>(builder: (BuildContext context, Widget child, ProductModel model) {
            return IconButton(
            icon: Icon(model.displayFavoritesOnly ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              model.toggleDisplayMode();
            },
          );
          },), 
        ],
      ),
      body: Products(),
    );
  }
}
