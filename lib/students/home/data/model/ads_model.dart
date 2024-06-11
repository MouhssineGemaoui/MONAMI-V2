class AdsModel {
  int? adsId;
  String? adsName;
  String? adsImage;

  AdsModel({this.adsId, this.adsName, this.adsImage});

  AdsModel.fromJson(Map<String, dynamic> json) {
    adsId = json['ads_id'];
    adsName = json['ads_name'];
    adsImage = json['ads_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ads_id'] = this.adsId;
    data['ads_name'] = this.adsName;
    data['ads_image'] = this.adsImage;
    return data;
  }
}