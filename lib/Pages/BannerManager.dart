import 'package:ahia_admin/Widgets/BannerWidgets/BannerUploadWidget.dart';
import 'package:ahia_admin/Widgets/BannerWidgets/BannerWidget.dart';
import 'package:ahia_admin/Widgets/SideBar.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class BannerScreen extends StatefulWidget {
  static const String id = 'banner-manager';

  @override
  _BannerScreenState createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
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
      sideBar: _sideBar.sideBarMenus(context, BannerScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Banner',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add/Delete Main Page banner'),
              Divider(
                thickness: 5,
              ),
              // Banners
              BannerWidget(),

              Divider(
                thickness: 5,
              ),
              BannerUploadWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
