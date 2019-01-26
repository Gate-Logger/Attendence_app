import 'package:attendence_app/database/index.dart';
import 'package:attendence_app/employee-panel/register.dart';
import 'package:attendence_app/model/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// Future<List<Employee>> fetchEmployeesFromDatabase() async {
//   var dbHelper = DBHelper();
//   Future<List<Employee>> employees = dbHelper.getEmployees();
//   print('Employess get Part !!! ${employees}');
//   return employees;
// }

class EmployeeInfo extends StatefulWidget {
  @override
  _EmployeeInfoState createState() => new _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
  List<Employee> items;
  FirebaseFirestoreService db = new FirebaseFirestoreService();
 
  StreamSubscription<QuerySnapshot> employeeSub;
 
  @override
  void initState() {
    super.initState();
 
    items = new List();
 
    employeeSub?.cancel();
    employeeSub = db.getEmployeeList().listen((QuerySnapshot snapshot) {
      final List<Employee> employee = snapshot.documents
          .map((documentSnapshot) => Employee.fromMap(documentSnapshot.data))
          .toList();
 
      setState(() {
        this.items = employee;
      });
    });
  }
 
  @override
  void dispose() {
    employeeSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Employee List'),
      ),
      body: new Center(
        // padding: new EdgeInsets.all(16.0),
        // child: new FutureBuilder<List<Employee>>(
        //   future: fetchEmployeesFromDatabase(),
        //   builder: (context, snapshot) {
        //     print('Snapshot !!!!! ${snapshot}'); 
           // if (snapshot.connectionState != ConnectionState.waiting && snapshot.hasData && snapshot.data.length != null && snapshot.data.length != 0) {
               child: new ListView.builder(
                    itemCount: items.length != null && items.length != 0 ? items.length : 0,
                    itemBuilder: (context, index) {
                      var name = items[index].firtsName + ' ' + items[index].lastName;
                    return new Container(
                      child: new Center(
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new ListTile(
                              leading: new Icon(Icons.account_circle),
                              title: new Text(name, 
                              softWrap: true,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),),
                                  //subtitle: new Text(snapshot.data[index].mobileNo),
                                  subtitle: new Column(
                                    children: <Widget>[
                                      new Row(
                                    children: <Widget>[
                                      new Text('Id:', 
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 10.0,
                                      ),),
                                      new Text(items[index].empId,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 10.0,
                                      ),),
                                    ],
                                  ),
                                      new Row(
                                    children: <Widget>[
                                      new Text('Mobile No:', 
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 10.0,
                                      ),),
                                      new Text(items[index].mobileNo,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 10.0,
                                      ),),
                                    ],
                                  ),
                                    ],
                                  ),
                                trailing: new Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                  GestureDetector(
                                    onTap: () => _navigateToNote(context, items[index]),
                                    child: new Icon(Icons.edit),
                                  ),
                                  GestureDetector(
                                    onTap: () => _deleteNote(context, items[index], index),
                                    child: new Icon(Icons.delete),
                                  ),
                                  ],
                                ),
                            ),
                          ],
                        ),
                      ),
                    );
                    }),
            // } else if (snapshot.connectionState != ConnectionState.waiting && snapshot.data.length == 0) {
            //   return new Text("No Data found");
            // }
           // return new Container(alignment: AlignmentDirectional.center,child: new CircularProgressIndicator(),);
        //   },
        // ),
         
      ),
       floatingActionButton:  FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
    );
  }
  
 void _deleteNote(BuildContext context, Employee employee, int position) async {
    db.deleteEmployee(employee.documentId).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }
  void _navigateToNote(BuildContext context, Employee employee) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register(employee)),
    );
  }
   void _createNewNote(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register(Employee(null, null, '', '', ''))),
    );
  }
}
