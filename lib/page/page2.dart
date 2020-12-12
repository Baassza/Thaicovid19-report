import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:covit19_report/page/appdrawer.dart';
import 'package:http/http.dart' show get;
import 'package:rounded_flutter_datetime_picker/rounded_flutter_datetime_picker.dart';
import 'models/sumcase.dart';
var txtdate="";
var difference;
var difference_now;
var len;
var flag=0;
final birthday = DateTime(2020, 1, 1);
setinit(){
  if(flag==0) {
    difference = DateTime
        .now()
        .difference(birthday)
        .inDays;
    if (difference == len) {
      difference--;
    }
    else if(difference>len){
      difference=len-1;
    }
    flag=1;
  }
  
}
class covitservice {
  static Future<sumcase> Daysummary() async {
    var res = await get("https://covid19.th-stat.com/api/open/timeline");
    Map json = jsonDecode(res.body);
    sumcase msg = sumcase.fromJson(json);
    len=msg.data.length;
    for(var i=0;i<len;i++){
      if(msg.data[i].newHospitalized<=0){
        msg.data[i].newHospitalized=0;
      }
    } 
    await setinit();
    return msg;
  }
}

class Daysummary extends StatefulWidget {
  @override
  _DaysummaryState createState() => _DaysummaryState();
}

class _DaysummaryState extends State<Daysummary> {
  @override
  void initState() {
    update_date(DateTime.now(), true);
    flag=0;
    covitservice.Daysummary();
    super.initState();
    
  }

  Widget Date(){
    return FlatButton(
        onPressed: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(2020, 1, 1),
              maxTime: DateTime(2022, 1, 1),
              onConfirm: (date) {
                setState(() {
                  difference_now = DateTime.now().difference(date).inDays;
                  difference=date.difference(birthday).inDays;
                  if(difference_now<0){
                    difference=DateTime.now().difference(birthday).inDays;
                    if(difference>=len) {
                      var diff=(difference-len)+1;
                      difference=difference-diff;
                    }
                    update_date(date,false);}
                  else if(difference_now==0){update_date(date,false);
                  if(difference>=len) {
                    var diff=(difference-len)+1;
                      difference=difference-diff;
                  }
                  }

                  else{
                    update_date(date,true);}
                  ;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.th);
        },
        child: Text(
          "กดเพื่อเลือกวัน",
          style: TextStyle(color: Colors.teal,fontSize: 24,fontFamily: "Kanit"),
        ));
  }
 Widget UI(){
   return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
     Title(),
     Textdate(),
      Date(),
     Topcard(),
     Rowcard(),
   ],
   );
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawermanu(),
      backgroundColor: Color.fromRGBO(219, 195, 57, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: UI(),
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

Widget Textdate(){
  return Text(txtdate.toString(),style: TextStyle(color: Colors.teal,fontSize: 24,fontFamily: "Kanit"));
}
update_date(DateTime date,bool over){
  if(over) {
    if (date.day < 10) {
      if (date.month >= 10) {
        txtdate =
            "0" + date.day.toString() + "/" + date.month.toString() + "/" +
                date.year.toString();
      }
      else {
        txtdate =
            "0" + date.day.toString() + "/" + "0" + date.month.toString() +
                "/" + date.year.toString();
      }
    }
    else {
      if (date.month >= 10) {
        txtdate = date.day.toString() + "/" + date.month.toString() + "/" +
            date.year.toString();
      }
      else {
        txtdate =
            date.day.toString() + "/" + "0" + date.month.toString() + "/" +
                date.year.toString();
      }
    }
  }
else{
    if (DateTime.now().day < 10) {
      if (DateTime.now().month >= 10) {
        txtdate =
            "0" + DateTime.now().day.toString() + "/" + DateTime.now().month.toString() + "/" +
                DateTime.now().year.toString();
      }
      else {
        txtdate =
            "0" + DateTime.now().day.toString() + "/" + "0" + DateTime.now().month.toString() +
                "/" + DateTime.now().year.toString();
      }
    }
    else {
      if (DateTime.now().month >= 10) {
        txtdate = DateTime.now().day.toString() + "/" + DateTime.now().month.toString() + "/" +
            DateTime.now().year.toString();
      }
      else {
        txtdate =
            DateTime.now().day.toString() + "/" + "0" + DateTime.now().month.toString() + "/" +
                DateTime.now().year.toString();
      }
    }
  }
}



class Topcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: covitservice.Daysummary(),
        builder: (context, snapshot) {
          if (snapshot.hasData&&flag==1) {
            sumcase msg = snapshot.data;
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
                        child: Text(msg.data[difference].confirmed.toString(),
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
                                msg.data[difference].newConfirmed.toString() +
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
          future: covitservice.Daysummary(),
          builder: (context, snapshot) {
            if (snapshot.hasData&&flag==1) {
              sumcase msg = snapshot.data;
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
                          child: Text(msg.data[difference].recovered.toString(),
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
                                  msg.data[difference].newRecovered.toString() +
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
          future: covitservice.Daysummary(),
          builder: (context, snapshot) {
            if (snapshot.hasData&&flag==1) {
              sumcase msg = snapshot.data;
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
                          child: Text(msg.data[difference].hospitalized.toString(),
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
                                  msg.data[difference].newHospitalized.toString() +
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
          future: covitservice.Daysummary(),
          builder: (context, snapshot) {
            if (snapshot.hasData&&flag==1) {
              sumcase msg = snapshot.data;
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
                          child: Text(msg.data[difference].deaths.toString(),
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
                                  msg.data[difference].newDeaths.toString() +
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
