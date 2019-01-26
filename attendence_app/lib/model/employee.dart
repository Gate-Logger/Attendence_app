class Employee {
  String _documentId;
  String _empId;
  String _firstName;
  String _lastName;
  String _mobileNo;
 
  Employee(this._documentId, this._empId, this._firstName, this._lastName, this._mobileNo);
 
  Employee.map(dynamic obj) {
    this._documentId = obj['documentId'];
    this._empId = obj['empId'];
    this._firstName = obj['firstName'];
    this._lastName = obj['lastName'];
    this._mobileNo = obj['mobileNo'];
  }
 
  String get documentId => _documentId;
  String get empId => _empId;
  String get firtsName => _firstName;
  String get lastName => _lastName;
  String get mobileNo => _mobileNo;
  
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_documentId != null) {
      map['documentId'] = _documentId;
    }
     map['empId'] = _empId;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['mobileNo'] = _mobileNo;
   
 
    return map;
  }
 
  Employee.fromMap(Map<String, dynamic> map) {
     this._documentId = map['documentId'];
    this._empId = map['empId'];
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._mobileNo = map['mobileNo'];
   
  }
}