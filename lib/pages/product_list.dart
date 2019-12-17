import 'package:easylist2/models/product.dart';
import 'package:flutter/material.dart';

import 'product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;


  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => ProductEditPage(
                              product: products[index],
                              updateProduct: updateProduct,
                              productIndex: index,
                            ),
                          ),
                        );
                      },
                    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(products[index].title),
          onDismissed: (DismissDirection direction) {
            if (direction == DismissDirection.endToStart) {
              print('end to start. product deleted');
              deleteProduct(index);
            } else if (direction == DismissDirection.startToEnd) {
              print('start to end');
            } else {
              print('other swipe');
            }
          },
          background: Container(color: Colors.red[900],),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        products[index].image,
                      ),
                    ),
                    title: Text(products[index].title),
                    subtitle: Text('\$${products[index].price}'),
                    trailing: _buildEditButton(context, index),
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
  }
}
