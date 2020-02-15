import 'package:brow_crow/services/auth.dart';
import 'package:brow_crow/shared/constant.dart';
import 'package:brow_crow/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // text faild state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  // object of AuthService
  final AuthService _authService = AuthService();

  // creating a globel form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              centerTitle: true,
              title: Text('Sign in'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Email',
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Please enter an email' : null,
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (value) => value.length < 8
                          ? 'Please enter a password more than 8 charecter'
                          : null,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
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
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            widget.toggleView();
                          },
                        ),
                        RaisedButton(
                          color: Colors.brown[400],
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            signInButton();
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

  void signInButton() async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      dynamic result = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );
      if (result == null) {
        setState(
          () {
            error = 'Please enter a valid email and password';
            loading = false;
          },
        );
      }
    }
  }
}
