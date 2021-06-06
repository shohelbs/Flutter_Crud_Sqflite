class Customer {
  int id;
  String name;
  String email;
  static final String tblName = 'Customer';

  Customer(this.name, this.email);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["email"] = email;
    return map;
  }

  Customer.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.email = obj['email'];
  }
}
