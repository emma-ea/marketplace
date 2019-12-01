import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {

  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  _ProductCreatePageState createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {

  String _titleValue = '';
  String _descriptionValue = '';
  double _priceValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: ListView(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: 'Product Title',
          ),
          onChanged: (input) {
            setState(() {
              _titleValue = input;
            });
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Product Description',
          ),
          maxLines: 4,
          onChanged: (input) {
            setState(() {
              _descriptionValue = input;
            });
          },
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Product Price',
          ),
          keyboardType: TextInputType.number,
          onChanged: (input) {
            _priceValue = double.parse(input);
          },
        ),
        SizedBox(height: 12.0,),
        RaisedButton(
          color: Theme.of(context).accentColor,
          textColor: Colors.white,
          child: Text('Save'),
          onPressed: () {
            final Map<String, dynamic> product = {
              'title': _titleValue,
              'description': _descriptionValue,
              'price': _priceValue,
              'image': 'assets/images/food.jpg'
            };
            widget.addProduct(product);
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ],
    ),);
  }
}
