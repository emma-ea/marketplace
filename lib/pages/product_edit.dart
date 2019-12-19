import 'package:easylist2/models/product.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/images/food.jpg'
  };

  Widget _buildTitleTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Title',
      ),
      initialValue: product == null ? '' : product.title,
      validator: (input) =>
          input.isEmpty || input.length < 5 ? 'Title is required' : null,
      onSaved: (input) {
        _formData['title'] = input;
      },
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Description',
      ),
      maxLines: 4,
      initialValue: product == null ? '' : product.description,
      validator: (String input) {
        if (input.isEmpty || input.length < 10) {
          return 'Description is required. Length should be 10+';
        }
        return null;
      },
      onSaved: (input) {
        _formData['description'] = input;
      },
    );
  }

  Widget _buildPriceTextField(Product product) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Price',
      ),
      keyboardType: TextInputType.number,
      initialValue: product == null ? '' : product.price.toString(),
      validator: (input) {
        if (input.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(input)) {
          return 'Price is required. Should be number';
        }
        return null;
      },
      onSaved: (input) {
        _formData['price'] = double.parse(input);
      },
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
            textColor: Colors.white,
            child: Text('Save'),
            onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.selectProduct,
                model.selectedProductIndex));
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(
                height: 12.0,
              ),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  _submitForm(Function addProduct, Function updateProduct, Function setSelectedProduct, 
      [int selectProductIndex]) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    if (selectProductIndex == null) {
      addProduct(
          _formData['title'],
          _formData['description'],
          _formData['image'], 
          _formData['price'],);
    } else {
      updateProduct(
          _formData['title'],
          _formData['description'],
          _formData['image'], 
          _formData['price'], );
    }
    Navigator.pushReplacementNamed(context, '/products').then((_) => setSelectedProduct(null));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
