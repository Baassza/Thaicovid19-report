class dcase {
  List<Data> data;

  dcase({this.data});

  dcase.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String confirmDate;
  String no;
  dynamic age;
  String gender;
  String genderEn;
  String nation;
  String nationEn;
  String province;
  dynamic provinceId;
  String district;
  String provinceEn;
  Null detail;

  Data(
      {this.confirmDate,
      this.no,
      this.age,
      this.gender,
      this.genderEn,
      this.nation,
      this.nationEn,
      this.province,
      this.provinceId,
      this.district,
      this.provinceEn,
      this.detail});

  Data.fromJson(Map<String, dynamic> json) {
    confirmDate = json['ConfirmDate'];
    no = json['No'];
    age = json['Age'];
    gender = json['Gender'];
    genderEn = json['GenderEn'];
    nation = json['Nation'];
    nationEn = json['NationEn'];
    province = json['Province'];
    provinceId = json['ProvinceId'];
    district = json['District'];
    provinceEn = json['ProvinceEn'];
    detail = json['Detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ConfirmDate'] = this.confirmDate;
    data['No'] = this.no;
    data['Age'] = this.age;
    data['Gender'] = this.gender;
    data['GenderEn'] = this.genderEn;
    data['Nation'] = this.nation;
    data['NationEn'] = this.nationEn;
    data['Province'] = this.province;
    data['ProvinceId'] = this.provinceId;
    data['District'] = this.district;
    data['ProvinceEn'] = this.provinceEn;
    data['Detail'] = this.detail;
    return data;
  }
}