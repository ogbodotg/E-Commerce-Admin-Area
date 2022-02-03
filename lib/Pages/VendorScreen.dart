import 'package:ahia_admin/Widgets/SideBar.dart';
import 'package:ahia_admin/Widgets/VendorWidgets/VendorDataTable.dart';
import 'package:ahia_admin/Widgets/VendorWidgets/VendorsFilter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class VendorScreen extends StatefulWidget {
  static const String id = 'vendor-screen';
  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  SideBarWidget _sideBar = SideBarWidget();

  @override
  Widget build(BuildContext context) {
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
      sideBar: _sideBar.sideBarMenus(context, VendorScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vendors',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Manage Vendors'),
              Divider(thickness: 5),
              // VendorFilterWidget(),
              // Divider(thickness: 5),
              VendorDataTable(),
              Divider(thickness: 5),
            ],
          ),
        ),
      ),
    );
  }
}
