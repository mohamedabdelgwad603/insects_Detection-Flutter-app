class InsectsModel {
  bool? status;
  dynamic code;

  List<InsectsDataModel> data = [];
  InsectsModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];

    json['data'].forEach((element) {
      data.add(InsectsDataModel.fromjson(element));
    });
  }
}

class InsectsDataModel {
  int? id;
  String? img;
  String? date;
  ReponseData? data;
  InsectsDataModel.fromjson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      img = json['photo'];
      date = json['created_at'];

      data = ReponseData.fromjson(json['response']);
    }
  }
}

class ReponseData {
  String? message;
  dynamic ccN;
  dynamic bzN;

  ReponseData.fromjson(Map<String, dynamic>? json) {
    if (json != null) {
      message = json['message'];
      bzN = json['n_bz'];
      ccN = json['n_cc'];
    }
  }
}
