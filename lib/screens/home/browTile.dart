import 'package:brow_crow/models/brow.dart';
import 'package:flutter/material.dart';

class BrowTile extends StatelessWidget {
  final Brow brow;
  BrowTile({this.brow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 24.0,
        margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/coffee_icon.png'),
            backgroundColor: Colors.brown[brow.strength],
            radius: 24.0,
          ),
          title: Text(
            brow.name,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          subtitle: Text('Takes ${brow.sugars} Sugars'),
        ),
      ),
    );
  }
}
