import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;
  Uri Yurl = Uri.https('www.youtube.com', '/', {'q': 'dart'});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:
            PreferredSize(
              preferredSize:const Size.fromHeight(50),
              child:
               SafeArea(
                 child: Container(
                 color: Colors.lightBlue,
                             child: Row(children: [
                             ButtonBar(
                           alignment: MainAxisAlignment.spaceAround,
                           children: <Widget>[
                             FloatingActionButton(
                  child: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController.goBack();
                    }
                  },
                             ),
                             FloatingActionButton(
                  child: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController.goForward();
                    }
                  },
                             ),
                             FloatingActionButton(
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController.reload();
                    }
                  },
                             ),
                           ],
                         ),
                             ],),
                           ),
               )),
        body: Container(
            child: Column(children: <Widget>[
          
          Container(
              padding: EdgeInsets.all(10.0),
              child: progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container()),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(2.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Yurl),
                
                initialOptions: InAppWebViewGroupOptions(

                    crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                )),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ),
          
        ])),
      ),
    );
  }
}
