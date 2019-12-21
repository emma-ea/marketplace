import 'package:easylist2/scoped-models/main.dart';
import 'package:easylist2/widgets/products/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///
/// all products list page
///

class ProductsPage extends StatefulWidget {

  final MainModel model;

  ProductsPage(this.model);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  @override
  initState() {
    widget.model.fetchProduct();
    super.initState();
  }
  
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

  Widget _buildProductList() {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
      Widget content = Center(child: Text('No Products Found!'),);
      if (model.displayProducts.length > 0 && !model.isLoading) {
        content = Products();
      } else if (model.isLoading){
        content = Center(child: CircularProgressIndicator());
      }
      return RefreshIndicator(onRefresh: model.fetchProduct, child: content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('Marketplace'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
            return IconButton(
            icon: Icon(model.displayFavoritesOnly ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              model.toggleDisplayMode();
            },
          );
          },), 
        ],
      ),
      body: _buildProductList(), 
    );
  }
}
