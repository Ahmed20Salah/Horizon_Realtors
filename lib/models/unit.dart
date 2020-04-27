class Unit {
  int cost;
  String time;
  int number;
  Unit.fromMap(json, number) {
    this.cost = json['cost'];
    this.time = json['created'];
    this.number = number;
  }
}
