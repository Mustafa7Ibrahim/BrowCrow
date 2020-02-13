import 'package:brow_crow/models/brow.dart';
import 'package:brow_crow/screens/home/browTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrowsList extends StatefulWidget {
  @override
  _BrowsListState createState() => _BrowsListState();
}

class _BrowsListState extends State<BrowsList> {
  @override
  Widget build(BuildContext context) {
    final brows = Provider.of<List<Brow>>(context) ?? [];

    return ListView.builder(
      itemCount: brows.length,
      itemBuilder: (context, index) {
        return BrowTile(brow: brows[index]);
      },
    );
  }
}
