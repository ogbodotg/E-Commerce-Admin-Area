import 'package:ahia_admin/Pages/HomeScreen.dart';
import 'package:ahia_admin/Services/Firebase_Services.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login-screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _formKey = GlobalKey<FormState>();
  FirebaseServices _firebaseServices = FirebaseServices();
  var _usernameTextController = TextEditingController();
  var _passwordTextController = TextEditingController();

  // String username;
  // String password;

  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(.8),
        animationDuration: Duration(milliseconds: 500));

    _login({username, password}) async {
      progressDialog.show();
      _firebaseServices.getAdminCredentials(username).then((value) async {
        if (value.exists) {
          if (value.data()['username'] == username) {
            if (value.data()['password'] == password) {
              try {
                UserCredential userCredential =
                    await FirebaseAuth.instance.signInAnonymously();
                if (userCredential != null) {
                  progressDialog.dismiss();
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                }
              } catch (e) {
                progressDialog.dismiss();
                _firebaseServices.showMyDialog(
                    context: context,
                    title: 'Invalid code',
                    message: '${e.toString()}');
              }
              return;
            }
            progressDialog.dismiss();
            _firebaseServices.showMyDialog(
              context: context,
              title: 'Invalid code',
              message:
                  'Invalid login credentials. You are not allowed to access this page',
            );
            return;
          }
          progressDialog.dismiss();
          _firebaseServices.showMyDialog(
            context: context,
            title: 'Invalid user',
            message:
                'Invalid login credentials. You are not allowed to access this page',
          );
        }
        progressDialog.dismiss();
        _firebaseServices.showMyDialog(
          context: context,
          title: 'Invalid username',
          message:
              'Invalid login credentials. You are not allowed to access this page',
        );
      });
    }
    // Future<void> _login() async {
    //   progressDialog.show();
    //   _firebaseServices.getAdminCredentials().then((value) {
    //     value.docs.forEach((doc) async {
    //       if (doc.get('username') == username) {
    //         if (doc.get('password') == password) {
    //           UserCredential userCredential =
    //               await FirebaseAuth.instance.signInAnonymously();
    //           progressDialog.dismiss();
    //           if (userCredential.user.uid != null) {
    //             Navigator.pushReplacement(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (BuildContext context) => HomeScreen()));
    //             return;
    //           } else {
    //             _showMyDialog(
    //               title: 'Login',
    //               message: 'Login failed',
    //             );
    //           }
    //         } else {
    //           progressDialog.dismiss();
    //           _showMyDialog(
    //               title: 'Invalid login',
    //               message:
    //                   'Invalid login credentials. You are not allowed to access this page');
    //         }
    //       } else {
    //         progressDialog.dismiss();
    //         _showMyDialog(
    //             title: 'Invalid User',
    //             message:
    //                 'Invalid login credentials. You are not allowed to access this page');
    //       }
    //     });
    //   });
    // }

    return Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title, style: TextStyle(color: Colors.white)),
        //   centerTitle: true,
        //   elevation: 0.0,
        // ),
        body: FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(child: Text('Connection Failed'));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // Color(0xFF84c225),
                  Colors.purple,
                  Colors.white,
                ],
                stops: [1.0, 1.0],
                begin: Alignment.topCenter,
                end: Alignment(0.0, 0.0),
              ),
            ),
            child: Center(
                child: Container(
                    width: 300,
                    height: 300,
                    child: Card(
                        elevation: 4.4,
                        shape: Border.all(
                            color: Theme.of(context).primaryColor, width: 2),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Text('Wiwa Admin Area',
                                          style: TextStyle(
                                              fontFamily: 'Signatra',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 40,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      SizedBox(height: 20),
                                      TextFormField(
                                        controller: _usernameTextController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter username';
                                          }
                                          // setState(() {
                                          //   username = value;
                                          // });

                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Username',
                                          prefixIcon: Icon(Icons.person),
                                          hintText: 'Username',
                                          focusColor:
                                              Theme.of(context).primaryColor,
                                          contentPadding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        controller: _passwordTextController,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter password';
                                          }
                                          // setState(() {
                                          //   password = value;
                                          // });

                                          return null;
                                        },
                                        // obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          prefixIcon:
                                              Icon(Icons.vpn_key_outlined),
                                          hintText: 'Password',
                                          focusColor:
                                              Theme.of(context).primaryColor,
                                          contentPadding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FlatButton(
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _login(
                                              username:
                                                  _usernameTextController.text,
                                              password:
                                                  _passwordTextController.text,
                                            );
                                          }
                                        },
                                        child: Text('Login',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )))),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: CircularProgressIndicator());
      },
    ));
  }
}
