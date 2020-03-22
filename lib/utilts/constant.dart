class Constant{
  static final _obj = Constant._internal();
  Constant._internal();
  factory Constant(){
    return _obj;
  }
  String url = 'http://webzone.ieeeshasb.org';
}
