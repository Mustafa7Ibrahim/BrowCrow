import 'package:brow_crow/services/auth.dart';
import 'package:brow_crow/shared/constant.dart';
import 'package:brow_crow/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // text faild state
  String email = '';
  String password = '';

  /* 
  whenever there is an error
  we update thid value to it and show it to the user
  */
  String error = '';

  // showing loading screan to user
  bool loading = false;

  // object of AuthService
  final AuthService _authService = AuthService();

  // creating a globel form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // if
    // loading = ture we show the loading screen
    // else
    // show the scaffold widget
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              centerTitle: true,
              title: Text('Sign Up'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Please enter an email' : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Password',
                      ),
                      validator: (value) => value.length < 8
                          ? 'Please enter a password more than 8 charecter'
                          : null,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                    ),
                    SizedBox(height: 12),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.brown[400],
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            widget.toggleView();
                          },
                        ),
                        RaisedButton(
                          color: Colors.brown[400],
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            registerButton();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  void registerButton() async {
    /* 
    checking if the validation is ture or not
    if ture we showing the loading screen and check the info.
    */
    if (_formKey.currentState.validate()) {
      // update the state of the app
      setState(() => loading = true);
      /* 
      make a conniction to firebase using _authService
      and provide the email and password 
      to check in it's avilable or not
      */
      dynamic result = await _authService.register(email, password);
      /*
       if the result = null 
       we back to register screen 
       show an error to the user
       */
      if (result == null) {
        // update the state of the app
        setState(() {
          loading = false;
          error = 'Please enter a valid email and password';
        });
      }
    }
  }
}
