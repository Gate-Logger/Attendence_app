import 'dart:async';
import 'package:attendence_app/model/employee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

 
final CollectionReference employeeCollection = Firestore.instance.collection('employee');
 
class FirebaseFirestoreService {
 
  static final FirebaseFirestoreService _instance = new FirebaseFirestoreService.internal();
 
  factory FirebaseFirestoreService() => _instance;
 
  FirebaseFirestoreService.internal();
 
  Future<Employee> createEmployee(String empId, String firstName, String lastName, String mobileNo) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(employeeCollection.document());
 
      final Employee employee = new Employee(ds.documentID, empId, firstName, lastName, mobileNo);
      final Map<String, dynamic> data = employee.toMap();
 
      await tx.set(ds.reference, data);
 
      return data;
    };
 
    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Employee.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }
 
  Stream<QuerySnapshot> getEmployeeList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = employeeCollection.snapshots();
 
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
 
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
 
    return snapshots;
  }
 
  Future<dynamic> updateEmployee(Employee employee) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(employeeCollection.document(employee.documentId));
 
      await tx.update(ds.reference, employee.toMap());
      return {'updated': true};
    };
 
    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
 
  Future<dynamic> deleteEmployee(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(employeeCollection.document(id));
 
      await tx.delete(ds.reference);
      return {'deleted': true};
    };
 
    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}

