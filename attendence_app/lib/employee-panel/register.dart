import 'dart:io';
import 'package:attendence_app/database/index.dart';
import 'package:attendence_app/model/employee.dart';
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
  final Employee employee;
  Register(this.employee);
  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  String empId;
  String firstName;
  String lastName;
  String mobileNo;
// final DocumentReference documentReference = Firestore.instance.document("Mydata/dummy");
//  StreamSubscription<DocumentReference> subscription;
FirebaseFirestoreService db = new FirebaseFirestoreService();
  File image;
TextEditingController _firstName;
TextEditingController _lastName;
TextEditingController _mobileNo;
  void initState() {
    super.initState();
 
    _firstName = new TextEditingController(text: widget.employee.firtsName);
    _lastName = new TextEditingController(text: widget.employee.lastName);
    _mobileNo = new TextEditingController(text: widget.employee.mobileNo);
  }
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
void resetFields() {
  this.setState(() {
    firstName = "";
    lastName = "";
    mobileNo = "";
  });
}
  void validateAndSubmit(documentId) async {
    if (validateAndSave()) {
      var mLength = mobileNo.length;
      var lastDigits = mobileNo.substring(mLength - 4, mLength);
      empId = lastDigits + firstName;
       if (documentId != null) {
                  db.updateEmployee(
                          Employee(documentId , empId, firstName, lastName, mobileNo))
                      .then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  db.createEmployee(empId, firstName, lastName, mobileNo).then((_) {
                    Navigator.pop(context);
                  });
                }
    //   var employee = Employee(empId, firstName, lastName, mobileNo, '0');
    //var dbHelper = FirebaseFirestoreService();
    //dbHelper.createEmployee(empId, firstName, lastName, mobileNo);
    resetFields();
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
        controller: _firstName,
        onSaved: (value) => firstName = value,
      ),
      TextFormField(
        key: Key('lastName'),
        decoration: InputDecoration(labelText: 'LastName'),
        validator: LastNameFieldValidator.validate,
        controller: _lastName,
        onSaved: (value) => lastName = value,
      ),
      TextFormField(
        key: Key('mobileNo'),
        controller: _mobileNo,
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
         key: Key('Register'),

         child: (widget.employee.documentId != null) ? Text('Update') : Text('Register'),
              



         //child: Text('Register', style: TextStyle(fontSize: 20.0)),
         onPressed: () => validateAndSubmit(widget.employee.documentId),
       ),
        // FloatingActionButton(
        //   onPressed: picker,
        //   child: new Icon(Icons.camera_alt),
        // ),
      ];
  }
}
