import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:covit19_report/page/appdrawer.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as Http;
import 'models/dcase.dart';
var len;
var num;
var textnum;
class covitservice {
  static Future<dcase> detailcase() async {
    var url = "https://covid19.th-stat.com/api/open/cases";
    var response = await Http.get(url);
    Map map = json.decode(response.body);
    dcase msg = dcase.fromJson(map);
    len = msg.data.length;
    for (var i = 0; i < len; i++) {
      msg.data[i].confirmDate =
          msg.data[i].confirmDate.replaceAll("00:00:00", '');
      var date = msg.data[i].confirmDate.split("-");
      msg.data[i].confirmDate =
          (date[2].trim() + "/" + date[1] + "/" + date[0]).trim();
      if (msg.data[i].district.isEmpty) {
        msg.data[i].district = "ไม่ทราบ";
      }
    }
    return msg;
  }
}

class Datacase extends StatefulWidget {
  @override
  _DatacaseState createState() => _DatacaseState();
}

class _DatacaseState extends State<Datacase> {
  @override
  void initState() {
    num = 0;
    covitservice.detailcase();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawermanu(),
      body: UI(),
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

class UI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ShowDetail(),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "รายงานข้อมูลแต่ละเคส",
        style: TextStyle(fontSize: 30, color: Colors.teal,fontFamily: "Kanit"),
      ),
    );
  }
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

class ShowDetail extends StatefulWidget {
  @override
  _ShowDetailState createState() => _ShowDetailState();
}

class _ShowDetailState extends State<ShowDetail> {
  @override
  var formkey = GlobalKey<FormState>();
  final clean = TextEditingController();
  clearTextInput() {
    clean.clear();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Title(),
          btngroup(),
          Form(
            child: ID(),
            key: formkey,
          ),
          byID(),
          detail(),
        ],
      ),
    );
  }

  Widget btngroup() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom:0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    num = len - 1;
                    clearTextInput();
                  });
                },
                child: Text(
                  "คนแรก",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Kanit",
                    color: Colors.white,
                  ),
                ),
                color: Colors.black87,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    num = 0;
                    clearTextInput();
                  });
                },
                child: Text(
                  "คนล่าสุด",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Kanit",
                    color: Colors.white,
                  ),
                ),
                color: Colors.black87,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ID() {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: TextFormField(
          controller: clean,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "คนที่",
            labelStyle: TextStyle(fontFamily: "Kanit"),
            helperText: "กรอกลำดับของคนที่ติดเชื้อได้ที่นี้",
            helperStyle: TextStyle(fontFamily: "Kanit")
          ),
          validator: (v) {
            if (isNumeric(v) == false) {
              return "กรุณากรอกเฉพาะตัวเลข";
            } else if (int.parse(v) <= 0) {
              return "กรุณากรอกเฉพาะตัวเลขจำนวนเต็มบวก";
            } else if (int.parse(v) >= len) {
              return "ไม่มีข้อมูลที่ร้องขอ";
            } else {
              return null;
            }
          },
          onSaved: (v) {
            setState(() {
              num = int.parse(v) - 1;
              clearTextInput();
            });
          },
        ),
      ),
    );
  }

  Widget byID() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        onPressed: () {
          if (formkey.currentState.validate()) {
            formkey.currentState.save();
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
        child: Text(
          "ค้นหา",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Kanit",
            color: Colors.white,
          ),
        ),
        color: Colors.black87,
      ),
    );
  }

  Widget detail() {
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "คนที่ ",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Kanit",
                color: Colors.teal,
              ),
            ),
          ),
          FutureBuilder(
              future: covitservice.detailcase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  dcase msg = snapshot.data;
                  if(num==0){textnum=len;}
                  else if(num==len-1){textnum=1;}
                  else{textnum=num+1;}
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      textnum.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Kanit",
                        color: Colors.teal,
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "วันที่ยืนยันผล ",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Kanit",
                color: Colors.teal,
              ),
            ),
          ),
          FutureBuilder(
              future: covitservice.detailcase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  dcase msg = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      msg.data[num].confirmDate,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Kanit",
                        color: Colors.teal,
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "อายุ ",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Kanit",
                color: Colors.teal,
              ),
            ),
          ),
          FutureBuilder(
              future: covitservice.detailcase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  dcase msg = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      msg.data[num].age.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Kanit",
                        color: Colors.teal,
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "เพศ ",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Kanit",
                color: Colors.teal,
              ),
            ),
          ),
          FutureBuilder(
              future: covitservice.detailcase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  dcase msg = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      msg.data[num].gender,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Kanit",
                        color: Colors.teal,
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "สัญชาติ ",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Kanit",
                color: Colors.teal,
              ),
            ),
          ),
          FutureBuilder(
              future: covitservice.detailcase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  dcase msg = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      msg.data[num].nation,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Kanit",
                        color: Colors.teal,
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "อำเภอ ",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Kanit",
                color: Colors.teal,
              ),
            ),
          ),
          FutureBuilder(
              future: covitservice.detailcase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  dcase msg = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      msg.data[num].district,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Kanit",
                        color: Colors.teal,
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "จังหวัด ",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Kanit",
                color: Colors.teal,
              ),
            ),
          ),
          FutureBuilder(
              future: covitservice.detailcase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  dcase msg = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      msg.data[num].province,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Kanit",
                        color: Colors.teal,
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    ]);
  }
}
