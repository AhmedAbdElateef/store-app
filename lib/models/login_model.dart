class ShopLoginModel {
  bool? status;
  String? message;
  UsersData? data;
  ShopLoginModel({this.status, this.message, this.data});
  ShopLoginModel.fromjson(json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? UsersData.fromjson(json["data"]):null ;
  }
}

class UsersData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  UsersData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });
  UsersData.fromjson(json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"];
    credit = json["credit"];
    token = json["token"];
  }
}
