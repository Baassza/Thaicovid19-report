import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:covit19_report/page/appdrawer.dart';
import 'package:http/http.dart';
import 'models/Provincenumber.dart';
var strpro = "กรุงเทพฯ,ภูเก็ต,นนทบุรี,ยะลา,สมุทรปราการ,สงขลา,ชลบุรี,ปัตตานี,เชียงใหม่,ปทุมธานี,นราธิวาส,นครปฐม,ชุมพร,กระบี่,สุราษฎร์ธานี,สตูล,นครราชสีมา,ฉะเชิงเทรา,ประจวบคีรีขันธ์,อุบลราชธานี,พัทลุง,บุรีรัมย์,สมุทรสาคร,นครศรีธรรมราช,นครสวรรค์,สระแก้ว,กาญจนบุรี,สุรินทร์,อุดรธานี,เชียงราย,ตรัง,ศรีสะเกษ,ปราจีนบุรี,ราชบุรี,พิษณุโลก,ขอนแกน,ระยอง,สุพรรณบุรี,เลย,แม่ฮ่องสอน,สระบุรี,พระนครศรีอยุธยา,ลำพูน,มุกดาหาร,ลำปาง,หนองบัวลำภู,ตาก,สุโขทัย,ร้อยเอ็ด,จันทบุรี,เพชรบูรณ์,อุตรดิตถ์,หนองคาย,พะเยา,ชัยภูมิ,กาฬสินธุ์,เพรชบุรี,อำนาจเจริญ,พังงา,นครพนม,นครนายก,ลพบุรี,แพร่,อุทัยธานี,ยโสธร,สกลนคร,สมุทรสงคราม,มหาสารคราม";
List prolist;
String _selectedLocation;
var ldata;
int num = 0;
int flag=0;
class covitservice {
  static Future<Provincenumber> Provincedata() async {
    var res = await get("https://covit-api-th.herokuapp.com/?num="+num.toString());
    Map json = jsonDecode(res.body);
    Provincenumber data = Provincenumber.fromJson(json);
    flag=1;
    return data;
  }
}

class Provincesummary extends StatefulWidget {
  @override
  _ProvincesummaryState createState() => _ProvincesummaryState();
}

class _ProvincesummaryState extends State<Provincesummary> {
  @override
  void initState() {
    num=0;
    prolist = strpro.split(",");
    _selectedLocation = prolist[0];
    covitservice.Provincedata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawermanu(),
      backgroundColor: Colors.grey[400],
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Center(
        child: loadUI(),
      ),
    );
  }
}

class loadUI extends StatefulWidget {
  @override
  _loadUIState createState() => _loadUIState();
}

class _loadUIState extends State<loadUI> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom:12),
              child: Title(),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: loaddropdown(),
            ),
            number(),
            kon(),
          ],
        ),
      ),
    );
  }

  Widget loaddropdown() {
    return DropdownButton(
      hint: Text('Please choose a location'), // Not necessary for Option 1
      value: _selectedLocation,
      onChanged: (newValue) {
        setState(() {
          _selectedLocation = newValue;
          num = prolist.indexOf(_selectedLocation);
          flag=0;
        });
      },
      items: prolist.map((location) {
        return DropdownMenuItem(
          child: new Text(
            location,
            style: TextStyle(
                fontFamily: "Kanit", fontSize: 24, color: Colors.teal),
          ),
          value: location,
        );
      }).toList(),
    );
  }

  Widget Title() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "รายงานยอดผู้ติดเชื้อแต่ละจังหวัด",
            style: TextStyle(fontSize: 24, fontFamily: "Kanit", color: Colors.teal),
          ),
        ],
      ),
    );
  }

  Widget number() {
    return FutureBuilder(
        future: covitservice.Provincedata(),
        builder: (context, snapshot) {
          if (snapshot.hasData&&flag==1) {
            Provincenumber data = snapshot.data;
            return Text(
              data.num.toString(),
              style: TextStyle(fontSize: 65, fontFamily: "Kanit", color: Colors.teal),
            );
          }
          else if(flag==0){
            return CircularProgressIndicator();
          }
          else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget kon() {
    return Text(
      "คน",
      style: TextStyle(fontSize: 65, fontFamily: "Kanit", color: Colors.teal),
    );
  }
}
