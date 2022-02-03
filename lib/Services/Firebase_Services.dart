import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference banners = FirebaseFirestore.instance.collection('slider');
  CollectionReference vendors =
      FirebaseFirestore.instance.collection('vendors');
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  CollectionReference deliveryAgents =
      FirebaseFirestore.instance.collection('AhiaDelivery');
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<DocumentSnapshot> getAdminCredentials(id) {
    var result =
        FirebaseFirestore.instance.collection('AhiaAdmin').doc(id).get();
    return result;
  }

  // homepage banner
  Future<String> uploadBannerImageToDb(url) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if (downloadUrl != null) {
      firestore.collection('slider').add({
        'banner': downloadUrl,
      });
    }
    return downloadUrl;
  }

  deleteBanner(id) async {
    firestore.collection('slider').doc(id).delete();
  }

  // vendor

  updateVendorStatus({id, status}) async {
    vendors.doc(id).update({
      'accountVerified': status ? false : true,
    });
  }

  updateTopPickedStatus({id, status}) async {
    vendors.doc(id).update({
      'isTopPicked': status ? false : true,
    });
  }

  // category
  Future<String> uploadCategoryImageToDb(url, catName) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    if (downloadUrl != null) {
      category.doc(catName).set({
        'categoryImage': downloadUrl,
        'categoryName': catName,
      });
    }
    return downloadUrl;
  }

  // save delivery agents
  Future<void> saveDeiveryAgent(email, password) async {
    deliveryAgents.doc(email).set({
      'email': email,
      'password': password,
      'phoneNumber': '',
      'accountVerified': false,
      'address': '',
      'city': '',
      'state': '',
      'deliveryAgentImage': '',
      'deliveryAgentName': '',
      'uid': '',
    });
  }

  // update delivery agent's status
  updateDeliveryAgentStatus({id, context, status}) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(.8),
        animationDuration: Duration(milliseconds: 500));
    progressDialog.show();

    // Create a reference to the document the transaction will use
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('AhiaDelivery').doc(id);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      // Get the document
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      }
      // perform update to document
      transaction.update(documentReference, {'accountVerified': status});
    }).then((value) {
      progressDialog.dismiss();
      showMyDialog(
        title: 'Delivery Agent Approval',
        message: status == true
            ? 'Delivery agent status APPROVED'
            : 'Delivery agent status DISAPPROVED',
        context: context,
      );
    }).catchError((error) => showMyDialog(
          context: context,
          title: 'Approval error',
          message: 'Failed to update delivery agent status: $error',
        ));
  }

  // message dialog box
  Future<void> confirmDeleteDialog({title, message, context, id}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteBanner(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog({title, message, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
