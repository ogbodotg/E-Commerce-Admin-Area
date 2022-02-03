import 'package:ahia_admin/Services/Firebase_Services.dart';
import 'package:ahia_admin/Widgets/VendorWidgets/VendorDetails.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VendorDataTable extends StatefulWidget {
  @override
  _VendorDataTableState createState() => _VendorDataTableState();
}

class _VendorDataTableState extends State<VendorDataTable> {
  FirebaseServices _services = FirebaseServices();

  int tag = 0;
  List<String> options = [
    'All Vendors',
    'Active Vendors',
    'Inactive Vendors',
    'Top Picked',
    'Top Rated',
    'Verified Vendors',
  ];

  bool topPicked;
  bool active;

  filter(val) {
    if (val == 1) {
      setState(() {
        active = true;
      });
    }

    if (val == 2) {
      setState(() {
        active = false;
      });
    }

    if (val == 3) {
      setState(() {
        topPicked = true;
      });
    }
    if (val == 0) {
      setState(() {
        topPicked = null;
        active = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ChipsChoice<int>.single(
          value: tag,
          onChanged: (val) {
            setState(() {
              tag = val;
            });
            filter(val);
          },
          choiceItems: C2Choice.listFrom<int, String>(
            activeStyle: (i, v) {
              return C2ChoiceStyle(
                brightness: Brightness.dark,
                color: Colors.black54,
              );
            },
            source: options,
            value: (i, v) => i,
            label: (i, v) => v,
          ),
        ),
        Divider(thickness: 5),
        StreamBuilder(
          stream: _services.vendors
              .where('isTopPicked', isEqualTo: topPicked)
              .where('accountVerified', isEqualTo: active)
              // .orderBy('shopName', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Oops... Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                showBottomBorder: true,
                dataRowHeight: 60,
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('Active / Inactive'),
                  ),
                  DataColumn(
                    label: Text('Top Picked'),
                  ),
                  DataColumn(
                    label: Text('Shop Name'),
                  ),
                  DataColumn(
                    label: Text('Ratings'),
                  ),
                  DataColumn(
                    label: Text('Total Sales'),
                  ),
                  DataColumn(
                    label: Text('Mobile'),
                  ),
                  DataColumn(
                    label: Text('Email'),
                  ),
                  DataColumn(
                    label: Text('View Details'),
                  ),
                ],
                rows: _vendorDetailsRows(snapshot.data, _services),
              ),
            );
          },
        ),
      ],
    );
  }

  List<DataRow> _vendorDetailsRows(
      QuerySnapshot snapshot, FirebaseServices services) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      return DataRow(cells: [
        DataCell(IconButton(
          onPressed: () {
            services.updateVendorStatus(
              id: document.data()['uid'],
              status: document.data()['accountVerified'],
            );
          },
          icon: document.data()['accountVerified']
              ? Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
        )),
        DataCell(IconButton(
          onPressed: () {
            services.updateTopPickedStatus(
              id: document.data()['uid'],
              status: document.data()['isTopPicked'],
            );
          },
          icon: document.data()['isTopPicked']
              ? Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                )
              : Icon(
                  null,
                ),
        )),
        DataCell(Text(document.data()['shopName'])),
        DataCell(
          Row(children: [
            Icon(Icons.star, color: Colors.grey),
            Text('3.5'),
          ]),
        ),
        DataCell(Text('10,000')),
        DataCell(Text(document.data()['phoneNumber'])),
        DataCell(Text('email')),
        DataCell(IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return VendorDetails(document.data()['uid']);
              },
            );
          },
        )),
      ]);
    }).toList();
    return newList;
  }
}
