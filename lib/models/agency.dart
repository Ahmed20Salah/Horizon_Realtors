class Agency {
  String name;
  int id;
  Agency.fromMAp(map) {
    this.name = map['agancy_name'];
    this.id = map['id'];
  }
}
