import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:covit19_report/page/appdrawer.dart';
import 'package:http/http.dart' show get;
import 'models/now.dart';

class covitservice {
  static Future<now> today() async {
    var res = await get("https://covid19.th-stat.com/api/open/today");
    Map json = jsonDecode(res.body);
    now data = now.fromJson(json);
    if (data.newHospitalized < 0) {
      data.newHospitalized = 0;
    }
    return data;
  }
}

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  @override
  void initState() {
    covitservice.today();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawermanu(),
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: UI(),
    );
  }
}

class UI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Title(),
        Date(),
        Topcard(),
        Rowcard(),
      ],
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Center(
        child: Text(
          "รายงานสถานการณ์ โควิด-19",
          style: TextStyle(
            fontSize: 28,
            color: Colors.teal,
            fontFamily: 'Kanit',
          ),
        ),
      ),
    );
  }
}

class Date extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("อัพเดทข้อมูลล่าสุด : ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontFamily: 'Kanit',
                )),
            FutureBuilder(
                future: covitservice.today(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    now data = snapshot.data;
                    return Text(data.updateDate.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                          fontFamily: 'Kanit',
                        ));
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class Topcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: covitservice.today(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            now data = snapshot.data;
            return Card(
              color: Colors.pinkAccent,
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.23,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(7),
                        child: Text("ติดเชื้อสะสม",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontFamily: 'Kanit',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(data.confirmed.toString(),
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: 'Kanit',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                            "(เพิ่มขึ้น " +
                                data.newConfirmed.toString() +
                                " คน)",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Kanit',
                            )),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class Rowcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Cardre(),
          Cardhos(),
          CardD(),
        ],
      ),
    );
  }
}

class Cardre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: FutureBuilder(
          future: covitservice.today(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              now data = snapshot.data;
              return Card(
                color: Colors.green,
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                  width: MediaQuery.of(context).size.width*0.28,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text("หายแล้ว",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'Kanit',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(data.recovered.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'Kanit',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                              "(เพิ่มขึ้น " +
                                  data.newRecovered.toString() +
                                  " คน)",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: 'Kanit',
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
class Cardhos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: FutureBuilder(
          future: covitservice.today(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              now data = snapshot.data;
              return Card(
                color: Colors.teal,
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                  width: MediaQuery.of(context).size.width*0.28,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text("อยู่ใน รพ.",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'Kanit',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(data.hospitalized.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'Kanit',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                              "(เพิ่มขึ้น " +
                                  data.newHospitalized.toString() +
                                  " คน)",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: 'Kanit',
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
class CardD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(top:8),
      child: FutureBuilder(
          future: covitservice.today(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              now data = snapshot.data;
              return Card(
                color: Colors.grey,
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Container(
                  width: MediaQuery.of(context).size.width*0.28,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text("เสียชีวิต",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'Kanit',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(data.deaths.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'Kanit',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                              "(เพิ่มขึ้น " +
                                  data.newDeaths.toString() +
                                  " คน)",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: 'Kanit',
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
