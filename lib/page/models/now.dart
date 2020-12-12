class now {
  dynamic confirmed;
  dynamic recovered;
  dynamic hospitalized;
  dynamic deaths;
  dynamic newConfirmed;
  dynamic newRecovered;
  dynamic newHospitalized;
  dynamic newDeaths;
  String updateDate;
  String source;
  String devBy;
  String severBy;

  now(
      {this.confirmed,
      this.recovered,
      this.hospitalized,
      this.deaths,
      this.newConfirmed,
      this.newRecovered,
      this.newHospitalized,
      this.newDeaths,
      this.updateDate,
      this.source,
      this.devBy,
      this.severBy});

  now.fromJson(Map<String, dynamic> json) {
    confirmed = json['Confirmed'];
    recovered = json['Recovered'];
    hospitalized = json['Hospitalized'];
    deaths = json['Deaths'];
    newConfirmed = json['NewConfirmed'];
    newRecovered = json['NewRecovered'];
    newHospitalized = json['NewHospitalized'];
    newDeaths = json['NewDeaths'];
    updateDate = json['UpdateDate'];
    source = json['Source'];
    devBy = json['DevBy'];
    severBy = json['SeverBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Confirmed'] = this.confirmed;
    data['Recovered'] = this.recovered;
    data['Hospitalized'] = this.hospitalized;
    data['Deaths'] = this.deaths;
    data['NewConfirmed'] = this.newConfirmed;
    data['NewRecovered'] = this.newRecovered;
    data['NewHospitalized'] = this.newHospitalized;
    data['NewDeaths'] = this.newDeaths;
    data['UpdateDate'] = this.updateDate;
    data['Source'] = this.source;
    data['DevBy'] = this.devBy;
    data['SeverBy'] = this.severBy;
    return data;
  }
}
