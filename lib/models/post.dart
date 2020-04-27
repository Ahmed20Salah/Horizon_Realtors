import 'package:horizon_realtors/models/user.dart';
import 'package:horizon_realtors/repository/user_repo.dart';

class Post {
  int id;
  List<String> imgs;
  String description;
  int price;
  int type;
  bool financeAvailability;
  String lang;
  String lant;
  String address;
  String mainAddress;
  int categoryId;
  int bedrooms;
  int bathrooms;
  int area;
  int sold;
  User user;
  UserRepository _userRepository = UserRepository();
  Post.fromMap(Map map) {
    this.id = map['id'];
    this.imgs = map['imgs'].split(',');
    this.description = map['des'];
    this.price = map['price'] is int ? map['price'] : int.parse(map['price']);
    this.sold = map['sold'] == null
        ? null
        : map['sold'] is int ? map['sold'] : int.parse(map['sold']);
    this.type = map['type'] is int ? map['type'] : int.parse(map['type']);
    this.financeAvailability = map['finance_availab'] is int
        ? map['finance_availab'] == 1 ? true : false
        : int.parse(map['finance_availab']) == 1 ? true : false;
    this.lang = map['land_location'];
    this.lant = map['lant_location'];
    this.categoryId = map['category_id'] is int
        ? map['category_id']
        : int.parse(map['category_id']);
    this.bedrooms = map['bed_rooms'] is int
        ? map['bed_rooms']
        : int.parse(map['bed_rooms']);
    this.bathrooms = map['bath_rooms'] is int
        ? map['bath_rooms']
        : int.parse(map['bath_rooms']);
    this.area = map['area'] is int ? map['area'] : int.parse(map['area']);
    this.user = _userRepository.user.type == UserType.EndUser
        ? User.fromMap(map['user_data'])
        : null;
  }

  toMap() {
    Map map = Map();
    map['id'] = this.id;
    map['description'] = this.description;
    map['imgs'] = this.imgs;
    map['price'] = this.price;
    map['sold'] = this.sold;
    map['type'] = this.type;
    map['finance_availab'] = this.financeAvailability;
    map['lant'] = this.lant;
    map['lang'] = this.lang;
    map['address'] = this.address;
    map['main_address'] = this.mainAddress;
    map['category_id'] = this.categoryId;
    map['bed_rooms'] = this.bedrooms;
    map['bath_rooms'] = this.bathrooms;
    map['area'] = this.area;
    return map;
  }
}

enum PropertyType { ForSale, ForRent }
