import 'package:attendence_app/employee-panel/register.dart';
import 'package:flutter/material.dart';

class EmployeePanel extends StatefulWidget{
  
  @override
  _EmployeePanelState createState() =>  new _EmployeePanelState();
}

class _EmployeePanelState extends State<EmployeePanel> {
  

_openRegisterScreen() {
  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Register()));
}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendece'),
      ),
      body: Container(
       child: new Center(
         child: new Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             new Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 RaisedButton(
               onPressed: _openRegisterScreen,
               child: new Text('Register'),
             ),
             RaisedButton(
               onPressed: (){},
               child: new Text('Edit'),
             ),
               ],
             ),
             new Padding(
               padding: EdgeInsets.all(10.0),
             ),
              new Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 RaisedButton(
               onPressed: () {},
               child: new Text('Delete'),
             ),
             RaisedButton(
               onPressed: (){},
               child: new Text('Fetch'),
             ),
               ],
             ),
           ],
         ),
       ), 
      ),
    );
  }
}