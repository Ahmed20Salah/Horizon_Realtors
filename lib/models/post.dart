import 'package:horizon_realtors/models/user.dart';

class Post {
  int id;
  List<String> imgs;
  String description;
  String price;
  PropertyType type;
  bool financeAvailability;
  String lang;
  String lant;
  String categoryId;
  String bedrooms;
  String bathrooms;
  String area;
  User user;

  Post.fromMap(Map map) {
    this.id = map['id'];
    this.imgs = map['imgs'].split(',');
    this.description = map['des'];
    this.price = map['price'];
    this.type =
        map['type'] == "1" ? PropertyType.ForRent : PropertyType.ForSale;
    this.financeAvailability = map['id'] == "1" ? true : false;
    this.lang = map['land_location'];
    this.lant = map['lant_location'];
    this.categoryId = map['category_id'];
    this.bedrooms = map['bed_rooms'];
    this.bathrooms = map['bath_rooms'];
    this.area = map['area'];
    this.user = User.fromMap(map['user_data']);
  }
}

enum PropertyType { ForSale, ForRent }
