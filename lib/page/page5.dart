import 'package:covit19_report/page/appdrawer.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class Web extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String url="https://covid19.ddc.moph.go.th/th/self_screening";
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,

    );
  }
}
class Selfassessment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawermanu(),
      body: Web(),
    );
  }
}