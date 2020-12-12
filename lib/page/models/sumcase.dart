class sumcase {
  String updateDate;
  String source;
  String devBy;
  String severBy;
  List<Data> data;

  sumcase({this.updateDate, this.source, this.devBy, this.severBy, this.data});

  sumcase.fromJson(Map<String, dynamic> json) {
    updateDate = json['UpdateDate'];
    source = json['Source'];
    devBy = json['DevBy'];
    severBy = json['SeverBy'];
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UpdateDate'] = this.updateDate;
    data['Source'] = this.source;
    data['DevBy'] = this.devBy;
    data['SeverBy'] = this.severBy;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String date;
  int newConfirmed;
  int newRecovered;
  int newHospitalized;
  int newDeaths;
  int confirmed;
  int recovered;
  int hospitalized;
  int deaths;

  Data(
      {this.date,
      this.newConfirmed,
      this.newRecovered,
      this.newHospitalized,
      this.newDeaths,
      this.confirmed,
      this.recovered,
      this.hospitalized,
      this.deaths});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    newConfirmed = json['NewConfirmed'];
    newRecovered = json['NewRecovered'];
    newHospitalized = json['NewHospitalized'];
    newDeaths = json['NewDeaths'];
    confirmed = json['Confirmed'];
    recovered = json['Recovered'];
    hospitalized = json['Hospitalized'];
    deaths = json['Deaths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.date;
    data['NewConfirmed'] = this.newConfirmed;
    data['NewRecovered'] = this.newRecovered;
    data['NewHospitalized'] = this.newHospitalized;
    data['NewDeaths'] = this.newDeaths;
    data['Confirmed'] = this.confirmed;
    data['Recovered'] = this.recovered;
    data['Hospitalized'] = this.hospitalized;
    data['Deaths'] = this.deaths;
    return data;
  }
}