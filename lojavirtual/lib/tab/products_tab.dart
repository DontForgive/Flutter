import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection('products').getDocuments(),
      builder: (context, snapshopt) {
        if (!snapshopt.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          var dividedTitles = ListTile.divideTiles(
                  tiles: snapshopt.data.documents.map((doc) {
                    return CategoryTile(doc);
                  }).toList(),
                  color: Colors.grey[500])
              .toList();

          return ListView(
            children: dividedTitles,
          );
        }
      },
    );
  }
}
