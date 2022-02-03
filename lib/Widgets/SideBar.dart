import 'package:ahia_admin/Pages/Administrators.dart';
import 'package:ahia_admin/Pages/BannerManager.dart';
import 'package:ahia_admin/Pages/DeliveryAgents.dart';
import 'package:ahia_admin/Pages/HomeScreen.dart';
import 'package:ahia_admin/Pages/LoginPage.dart';
import 'package:ahia_admin/Pages/NotificationScreen.dart';
import 'package:ahia_admin/Pages/Orders.dart';
import 'package:ahia_admin/Pages/ProductCategories.dart';
import 'package:ahia_admin/Pages/SettingScreen.dart';
import 'package:ahia_admin/Pages/VendorScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SideBarWidget {
  sideBarMenus(context, selectedRoute) {
    return SideBar(
      activeBackgroundColor: Colors.black54,
      activeIconColor: Colors.white,
      activeTextStyle: TextStyle(color: Colors.white),
      items: const [
        MenuItem(
          title: 'Home',
          route: HomeScreen.id,
          icon: Icons.dashboard,
        ),
        MenuItem(
          title: 'Banners',
          route: BannerScreen.id,
          icon: CupertinoIcons.photo,
        ),
        MenuItem(
          title: 'Vendors',
          route: VendorScreen.id,
          icon: Icons.store,
        ),
        MenuItem(
          title: 'Categories',
          route: ProductCategoryScreen.id,
          icon: Icons.category,
        ),
        MenuItem(
          title: 'Orders',
          route: Orders.id,
          icon: CupertinoIcons.cart_fill,
        ),
        MenuItem(
          title: 'Delivery Agents',
          route: DeliveryAgents.id,
          icon: Icons.delivery_dining,
        ),
        MenuItem(
          title: 'Send Notification',
          route: NotificationScreen.id,
          icon: Icons.notifications,
        ),
        MenuItem(
          title: 'Admin Users',
          route: AdminUsers.id,
          icon: Icons.person_rounded,
        ),
        MenuItem(
          title: 'Settings',
          route: SettingScreen.id,
          icon: Icons.settings,
        ),
        MenuItem(
          title: 'Exit',
          route: LoginPage.id,
          icon: Icons.close,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        Navigator.of(context).pushNamed(item.route);
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black26,
        child: Center(
          child: Text(
            'MENU',
            style: TextStyle(
              letterSpacing: 2,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black26,
        child: Center(
          child: Text(
            'Wiwa',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: 'Signatra',
              letterSpacing: 2,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
