import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class MyWebView extends StatelessWidget {
  final String url;
   bool isLoading=true;

MyWebView({required this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
       // title: const Text('SMART'),
     // ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted, // Enable JavaScript
      ),
    );
  }
}