import 'package:horizon_realtors/models/user.dart';
import 'package:horizon_realtors/repository/user_repo.dart';

class Post {
  int id;
  List<String> imgs;
  String description;
  int price;
  PropertyType type;
  bool financeAvailability;
  String lang;
  String lant;
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
    this.price = map['price'];
    this.sold = map['sold'];
    this.type = map['type'] == 1 ? PropertyType.ForRent : PropertyType.ForSale;
    this.financeAvailability = map['id'] == 1 ? true : false;
    this.lang = map['land_location'];
    this.lant = map['lant_location'];
    this.categoryId = map['category_id'];
    this.bedrooms = map['bed_rooms'];
    this.bathrooms = map['bath_rooms'];
    this.area = map['area'];
    this.user = _userRepository.user.type == UserType.EndUser
        ? User.fromMap(map['user_data'])
        : null;
  }
}

enum PropertyType { ForSale, ForRent }
