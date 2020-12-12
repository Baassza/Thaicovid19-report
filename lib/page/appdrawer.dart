import 'package:flutter/material.dart';
import "package:covit19_report/page/page1.dart";
import "package:covit19_report/page/page2.dart";
import "package:covit19_report/page/page3.dart";
import "package:covit19_report/page/page4.dart";
import "package:covit19_report/page/page5.dart";
class Drawermanu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(title:Text("เมนู"),
          automaticallyImplyLeading: false,
          ),
          ListTile(
            title: Text("แสดงค่าประจำวัน"),
            onTap: (){
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>new Today()));
            },
          ),
          ListTile(
            title: Text("ข้อมูลสรุปตามช่วงเวลา"),
            onTap: (){
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>new Daysummary()));
            },
          ),
          ListTile(
            title: Text("ข้อมูลแต่ละเคส"),
            onTap: (){
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>new Datacase()));
            },
          ),
          ListTile(
            title: Text("ข้อมูลสรุปจากเคส"),
            onTap: (){
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>new Provincesummary()));
            },
          ),
          ListTile(
            title: Text("แบบประเมินความเสี่ยงด้วยตนเอง"),
            onTap: (){
              Navigator.pushReplacement(context, new MaterialPageRoute(builder: (context)=>new Selfassessment()));
            },
          ),

        ],
      ),
    );
  }
}