class BrandModel {
  String brandId;
  String name;

  BrandModel({this.brandId, this.name});

  BrandModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['brand_id'] = this.brandId;
    data['name'] = this.name;

    return data;
  }
}