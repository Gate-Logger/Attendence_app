import 'package:flutter/material.dart';
import 'package:attendence_app/utils/navigator.dart';

class HomeScreen extends StatelessWidget{
  _adminRegister() {
   //return RootPage();
   //MyNavigator.goToHomeScreen(context)
  }
  Widget build(BuildContext context) {
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
               onPressed: () => MyNavigator.goToRootPage(context),
               child: new Text('Admin Register'),
             ),
             RaisedButton(
               onPressed: () => MyNavigator.goToRootPage(context),
               child: new Text('Employee Panel'),
             ),
               ],
             ),
             new Padding(
               padding: EdgeInsets.all(10.0),
             ),
             RaisedButton(
               onPressed: (){},
               child: new Text('Employee'),
             ),
           ],
         ),
       ), 
      ),
    );
  }
}