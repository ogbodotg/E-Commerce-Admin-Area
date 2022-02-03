import 'package:ahia_admin/Services/Firebase_Services.dart';
import 'package:ahia_admin/Widgets/DeliveryAgentsWidget/ApprovedDeliveryAgents.dart';
import 'package:ahia_admin/Widgets/DeliveryAgentsWidget/CreateDeliveryAgent.dart';
import 'package:ahia_admin/Widgets/DeliveryAgentsWidget/NewDeliveryAgents.dart';
import 'package:ahia_admin/Widgets/SideBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class DeliveryAgents extends StatelessWidget {
  static const String id = 'delivery-agents';

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sideBar = SideBarWidget();

    return DefaultTabController(
      length: 2,
      child: AdminScaffold(
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
        sideBar: _sideBar.sideBarMenus(context, DeliveryAgents.id),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Agents',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
                Text('Create and Manage Delivery Agents'),
                Divider(
                  thickness: 5,
                ),
                CreateNewDeliveryAgentWidget(),
                Divider(
                  thickness: 5,
                ),
                // list of delivery agents
                TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    Tab(text: 'New Delivery Agets'),
                    Tab(
                      text: 'Approved Delivery Aents',
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      children: [
                        NewDeliveryAgents(),
                        ApprovedDeliveryAgent(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
