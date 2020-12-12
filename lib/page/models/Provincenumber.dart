class Provincenumber {
  int num;

  Provincenumber({this.num});

  Provincenumber.fromJson(Map<String, dynamic> json) {
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    return data;
  }
}