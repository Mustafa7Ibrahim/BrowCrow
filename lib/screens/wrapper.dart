import 'package:brow_crow/models/user.dart';
import 'package:brow_crow/screens/authenticate/authenticate.dart';
import 'package:brow_crow/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // accesing the user data using the provider 
    final user = Provider.of<User>(context);

    // this use for return to either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}