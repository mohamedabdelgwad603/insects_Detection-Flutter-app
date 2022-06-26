import 'package:flutter/material.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("webView"),
      ),
      /* body: WebView(
        initialUrl: "http://mysterious-castle-43049.herokuapp.com",
      ),*/
    );
  }
}
