import 'package:brow_crow/models/user.dart';
import 'package:brow_crow/services/database.dart';
import 'package:brow_crow/shared/constant.dart';
import 'package:brow_crow/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  // declear a form key
  final _formKey = GlobalKey<FormState>();

  // create a list of number of sugers
  final List<String> sugars = ['0', '1', '2', '3', '4', '5', '6'];

  // Form value
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    // accesing the user data using the provider
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brow settings',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                // text field
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (value) =>
                      value.isEmpty ? 'Please Enter A Name' : null,
                  onChanged: (value) => setState(() => _currentName = value),
                ),
                SizedBox(height: 20.0),
                // dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar Sugars'),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _currentSugars = value),
                ),
                // slider
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  activeColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  onChanged: (value) =>
                      setState(() => _currentStrength = value.round()),
                ),
                RaisedButton(
                  color: Colors.brown[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseServices(uid: user.uid).updateUserData(
                        name: _currentName ?? userData.name,
                        strength: _currentStrength ?? userData.strength,
                        sugars: _currentSugars ?? userData.sugars,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
