import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:image_picker/image_picker.dart';


class FirstNameFieldValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'First name field can\'t be empty';
    }
    return null;
  }
}

class LastNameFieldValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Last name field can\'t be empty';
    }
    return null;
  }
}

class MobileFieldValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return 'Mobile No field can\'t be empty';
    } else if (value.length != 10) {
      return 'Mobile No. length can\'t be greater than or less than 10';
    }
    return null;
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  String empId;
  String firstName;
  String lastName;
  String mobileNo;
 final DocumentReference documentReference = Firestore.instance.document("Mydata/dummy");
//  StreamSubscription<DocumentReference> subscription;
  File image;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      var mLength = mobileNo.length;
      var lastDigits = mobileNo.substring(mLength - 4, mLength);
      empId = lastDigits + firstName;
Firestore.instance.runTransaction((Transaction transaction) async {
  CollectionReference reference = Firestore.instance.collection('add');
  await reference.add({
    "emp_id": empId,
    "first_name":  firstName,
    "last_name": lastName,
    "mobile_no": mobileNo,
  }).then((p) =>
    print('data added ${p}')
  ).catchError((e) =>
    print('Error is'+ e)
  );
});

    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Add Demo'),
      ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildInputs() + buildSubmitButtons(),
              ),
            )
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  List<Widget> buildInputs() {
    return [
      TextFormField(
        key: Key('firstName'),
        decoration: InputDecoration(labelText: 'FirstName'),
        validator: FirstNameFieldValidator.validate,
        onSaved: (value) => firstName = value,
      ),
      TextFormField(
        key: Key('lastName'),
        decoration: InputDecoration(labelText: 'LastName'),
        validator: LastNameFieldValidator.validate,
        onSaved: (value) => lastName = value,
      ),
      TextFormField(
        key: Key('mobileNo'),
        decoration: InputDecoration(labelText: 'Mobile No.'),
        validator: MobileFieldValidator.validate,
        onSaved: (value) => mobileNo = value,
      ),
      //image == null ? new Text('No Image') : new Image.file(image),
    ];
  }

  List<Widget> buildSubmitButtons() {
      return [
       RaisedButton(
         key: Key('signUp'),
         child: Text('Register', style: TextStyle(fontSize: 20.0)),
         onPressed: validateAndSubmit,
       ),
        // FloatingActionButton(
        //   onPressed: picker,
        //   child: new Icon(Icons.camera_alt),
        // ),
      ];
  }
}
