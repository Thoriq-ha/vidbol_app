import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebviewScreen extends StatefulWidget {
  final String url;
  const WebviewScreen({Key? key, required this.url}) : super(key: key);

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5,
        title: Text('Match View'),
      ),
      body: WebviewScaffold(
        url: widget.url,
      ),
    );
  }
}
