import 'package:brow_crow/models/brow.dart';
import 'package:brow_crow/screens/home/browsList.dart';
import 'package:brow_crow/screens/home/settingsForm.dart';
import 'package:brow_crow/services/auth.dart';
import 'package:brow_crow/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  // this an object of authService
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // this method show panel to the user
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brow>>.value(
      value: DatabaseServices().brows,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brow Crow'),
          centerTitle: true,
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () async {
              await _authService.signOut();
            },
          ),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(right: 16.0),
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrowsList(),
        ),
      ),
    );
  }
}
