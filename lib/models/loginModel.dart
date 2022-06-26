class ShopLoginModel {
  bool? status;
  String? message;
  userData? data;

  ShopLoginModel();

  ShopLoginModel.fromjson(Map<String, dynamic>? json) {
    if (json != null) {
      status = json['status'];
      message = json['message'];
      data = userData.fromjson(json['data']);
    }
  }
}

class userData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  userData.fromjson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      name = json['name'];
      email = json['email'];
      phone = json['phone'];
      image = json['image'];
      points = json['points'];
      credit = json['credit'];
      token = json['token'];
    }
  }
}
