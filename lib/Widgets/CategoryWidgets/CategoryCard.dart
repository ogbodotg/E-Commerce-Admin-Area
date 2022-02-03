import 'package:ahia_admin/Widgets/CategoryWidgets/SubCategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final DocumentSnapshot document;

  CategoryCard(this.document);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SubCategoryWidget(document['categoryName']);
          },
        );
      },
      child: SizedBox(
        height: 120,
        width: 120,
        child: Card(
          color: Colors.grey[100],
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Image.network(document['categoryImage']),
                ),
                FittedBox(
                    fit: BoxFit.contain,
                    child: Text(document['categoryName'],
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
