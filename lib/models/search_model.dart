class GetSearch {
  bool? status;
  GetData? data;
  GetSearch.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data = json["data"] != null ? GetData.fromjson(json["data"]) : null;
  }
}

class GetData {
  int? currentPage;
  List<Data> data = [];
  GetData.fromjson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    for (var x in json["data"]) {
      data.add(Data.fromjson(x));
    }
  }
}

class Data {
  int? id;
  dynamic price;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  Data.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
  }
}
