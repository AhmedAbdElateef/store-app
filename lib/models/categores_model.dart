class CategorisModel {
  bool? status;
  CategorisDataModel? data;
  CategorisModel.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data =CategorisDataModel.fromjson(json["data"]) ;
  }
}

class CategorisDataModel {
  int? currentPage;
  late List<DataModel> dataModel = [];
  CategorisDataModel.fromjson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    for (var x in json["data"]) {
      dataModel.add(DataModel.fromjson(x));
    }
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;
  DataModel.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}
