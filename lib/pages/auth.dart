import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';

enum AuthMode { LOGIN, SIGNUP }

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordEditTextController =
      TextEditingController();
  AuthMode _authMode = AuthMode.LOGIN;
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false,
  };

  DecorationImage _buildBackGroundImage() {
    return DecorationImage(
        image: AssetImage('assets/images/background.jpg'),
        fit: BoxFit.fill,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop));
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'Email', filled: true, fillColor: Colors.white),
      onSaved: (input) {
        _formData['email'] = input;
      },
      validator: (input) => input.isEmpty ||
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(input)
          ? 'Mail Required.'
          : null,
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      onSaved: (input) {
        _formData['password'] = input;
      },
      controller: _passwordEditTextController,
      validator: (input) => input.isEmpty || input.length < 6
          ? 'Password is Required. At least 6 characters'
          : null,
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Confirm Password', filled: true, fillColor: Colors.white),
      validator: (input) {
        if (_passwordEditTextController.text != input) {
          return 'Passwords do not match';
        }
        return null;
      },
      //validator: (input) => input.isEmpty || input.length < 6 ? 'Password is Required' : null,
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  void _submitForm(Function login, Function signup) async {
    if (!_formKey.currentState.validate() || !_formData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;

    if (_authMode == AuthMode.LOGIN) {
      successInformation =
          await login(_formData['email'], _formData['password']);
    } else {
      successInformation =
          await signup(_formData['email'], _formData['password']);
    }

    if (successInformation['success']) {
        Navigator.pushReplacementNamed(context, '/products');
      } else {
        showDialog(context: context, builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(child: Text('OKAY'), onPressed: () => Navigator.of(context).pop(),),
            ],
          );
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackGroundImage(),
        ),
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildEmailTextField(),
                    SizedBox(
                      height: 8.0,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 8.0,
                    ),
                    _authMode == AuthMode.SIGNUP
                        ? _buildConfirmPasswordTextField()
                        : Container(),
                    SizedBox(
                      height: 6.0,
                    ),
                    FlatButton(
                      child: Text(
                          'Switch to ${_authMode == AuthMode.LOGIN ? 'SignUp' : 'Login'}'),
                      onPressed: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.LOGIN
                              ? AuthMode.SIGNUP
                              : AuthMode.LOGIN;
                        });
                      },
                    ),
                    _buildAcceptSwitch(),
                    SizedBox(
                      height: 12.0,
                    ),
                    ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return model.isLoading ? Center(child: CircularProgressIndicator(),) : RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text(_authMode == AuthMode.LOGIN ? 'LOGIN' : 'SIGN UP'),
                          onPressed: () =>
                              _submitForm(model.login, model.signupNewUser),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
