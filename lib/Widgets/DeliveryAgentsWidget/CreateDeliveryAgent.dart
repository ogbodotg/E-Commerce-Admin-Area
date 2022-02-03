import 'package:ahia_admin/Services/Firebase_Services.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewDeliveryAgentWidget extends StatefulWidget {
  @override
  _CreateNewDeliveryAgentWidgetState createState() =>
      _CreateNewDeliveryAgentWidgetState();
}

class _CreateNewDeliveryAgentWidgetState
    extends State<CreateNewDeliveryAgentWidget> {
  FirebaseServices _services = FirebaseServices();

  bool _visible = false;
  var emailText = TextEditingController();
  var passwordText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(.8),
        animationDuration: Duration(milliseconds: 500));

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Visibility(
            visible: _visible ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Container(
                child: FlatButton(
                  child: Text(
                    'Create New Delivery Agent',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      _visible = true;
                    });
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          Visibility(
            visible: _visible,
            child: Container(
              // color: Colors.grey,
              // width: MediaQuery.of(context).size.width,
              // height: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 400,
                        height: 30,
                        child: TextField(
                          controller: emailText,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Delivery Agent\'s Email',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          controller: passwordText,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(left: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlatButton(
                        child: Text(
                          'Add New Delivery Agent',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (emailText.text.isEmpty) {
                            return _services.showMyDialog(
                              context: context,
                              title: 'Email',
                              message: 'Email field cannot be blank',
                            );
                          }
                          if (passwordText.text.isEmpty) {
                            return _services.showMyDialog(
                              context: context,
                              title: 'Password',
                              message: 'Password field cannot be blank',
                            );
                          }
                          if (passwordText.text.length < 8) {
                            return _services.showMyDialog(
                              context: context,
                              title: 'Password',
                              message:
                                  'Password cannot be less than 8 characters',
                            );
                          }
                          progressDialog.show();
                          _services
                              .saveDeiveryAgent(
                                  emailText.text, passwordText.text)
                              .whenComplete(() {
                            emailText.clear();
                            passwordText.clear();
                            progressDialog.dismiss();
                            _services.showMyDialog(
                              context: context,
                              title: 'Save Delivery Agent',
                              message: 'New Delivery Agent Added Successfully',
                            );
                          });
                        },
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
