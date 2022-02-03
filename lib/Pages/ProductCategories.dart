import 'package:ahia_admin/Widgets/CategoryWidgets/CategoryListWidget.dart';
import 'package:ahia_admin/Widgets/CategoryWidgets/CategoryUploadWidget.dart';
import 'package:ahia_admin/Widgets/SideBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class ProductCategoryScreen extends StatelessWidget {
  static const String id = 'product-category';
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Wiwa Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
      ),
      sideBar: _sideBar.sideBarMenus(context, ProductCategoryScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add Product Categories and Sub-Categories'),
              Divider(thickness: 5),
              CreateCategoryWidget(),
              Divider(thickness: 5),
              CategoryListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
