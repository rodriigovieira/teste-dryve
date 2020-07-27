class ColorModel {
  String colorId;
  String name;

  ColorModel({this.colorId, this.name});

  ColorModel.fromJson(Map<String, dynamic> json) {
    colorId = json['color_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_id'] = this.colorId;
    data['name'] = this.name;
    return data;
  }
}