class User {
  int id;
  String name;
  String email;
  String password;
  String phone;
  String token;
  UserType type;
  String agencyname;
  String image;

  User.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.email = map['email'];
    this.phone = map['phone'];
    this.token = map['token'];
    this.image = map['image'];
    this.type = map['role'] == "1"
        ? UserType.EndUser
        : map['role'] == "3" ? UserType.Agent : UserType.Agency;
    map['role'] == "3"
        ? this.agencyname = map['agency_name']
        : this.agencyname = null;
  }
  toMap() {
    var map = Map<String, dynamic>();
    map['name'] = this.name;
    map['email'] = this.email;
    map['phone'] = this.phone;
    map['role'] = this.type == UserType.EndUser
        ? "1"
        : this.type == UserType.Agency ? "2" : "3";
    map['agancy_name'] = this.agencyname;
    return map;
  }
}

enum UserType { EndUser, Agency, Agent }
