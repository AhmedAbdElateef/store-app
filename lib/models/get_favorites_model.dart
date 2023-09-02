class GetFavorites {
  bool? status;
  GetData? data;
  GetFavorites.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data = json["data"] != null ? GetData.fromjson(json["data"]) : null;
  }
}

class GetData {
  int? currentPage;
  late List<DetilsData> data = [];

  GetData.fromjson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    for (var x in json["data"]) {
      data.add(DetilsData.fromjson(x));
    }
  }
}

class DetilsData {
  int? id;
  DetilsDataAll? products;
  DetilsData.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    products = DetilsDataAll.fromjson(json["product"]);
  }
}

class DetilsDataAll {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  DetilsDataAll.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
  }
}
