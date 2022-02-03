import 'package:ahia_admin/Services/Firebase_Services.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class NewDeliveryAgents extends StatefulWidget {
  @override
  _NewDeliveryAgentsState createState() => _NewDeliveryAgentsState();
}

class _NewDeliveryAgentsState extends State<NewDeliveryAgents> {
  bool status = false;
  FirebaseServices _services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _services.deliveryAgents
            .where('accountVerified', isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong...');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          QuerySnapshot snap = snapshot.data;

          if (snap.size == 0) {
            return Center(
              child: Text('No new delivery agent to display'),
            );
          }

          return SingleChildScrollView(
            child: DataTable(
              showBottomBorder: true,
              dataRowHeight: 60,
              headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
              columns: <DataColumn>[
                DataColumn(
                  label: Text('Profile Image'),
                ),
                DataColumn(
                  label: Text('Name'),
                ),
                DataColumn(
                  label: Text('Email'),
                ),
                DataColumn(
                  label: Text('Phone Number'),
                ),
                DataColumn(
                  label: Text('Address'),
                ),
                DataColumn(
                  label: Text('City'),
                ),
                DataColumn(
                  label: Text('State'),
                ),
                DataColumn(
                  label: Text('Actions'),
                ),
              ],
              rows: _deliveryAgentList(snapshot.data, context),
            ),
          );
        },
      ),
    );
  }

  List<DataRow> _deliveryAgentList(QuerySnapshot snapshot, context) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      if (document != null) {
        return DataRow(cells: [
          DataCell(
            Container(
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: document.data()['deliveryAgentImage'] == ''
                      ? Icon(Icons.person,
                          size: 50, color: Theme.of(context).primaryColor)
                      : Image.network(document.data()['deliveryAgentImage'],
                          fit: BoxFit.cover),
                )),
          ),
          DataCell(
            Text(document.data()['deliveryAgentName']),
          ),
          DataCell(
            Text(document.data()['email']),
          ),
          DataCell(Text(
            document.data()['phoneNumber'],
          )),
          DataCell(Text(
            document.data()['address'],
          )),
          DataCell(Text(
            document.data()['city'],
          )),
          DataCell(Text(
            document.data()['state'],
          )),
          DataCell(
            document.data()['phoneNumber'] == ''
                ? Text('Not Registered')
                : FlutterSwitch(
                    activeText: "Approved",
                    inactiveText: "Not Approved",
                    value: document.data()['accountVerified'],
                    valueFontSize: 10.0,
                    width: 110,
                    borderRadius: 30.0,
                    showOnOff: true,
                    onToggle: (val) {
                      _services.updateDeliveryAgentStatus(
                        context: context,
                        id: document.id,
                        status: true,
                      );
                    },
                  ),
          ),
        ]);
      }
    }).toList();
    return newList;
  }
}
