import 'dart:html' as html;

import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';

class JusoPage extends StatefulWidget {
  final String title;
  JusoPage({Key key, this.title}) : super(key: key);

  _JusoPageState createState() => _JusoPageState();
}

class _JusoPageState extends State<JusoPage> {
  static ValueKey key = ValueKey('key_0');
  html.EventListener _messageEventListener = null;

  @override
  Widget build(BuildContext ctx) {
    return _buildWebview(ctx);
  }

  Widget _buildWebview(BuildContext ctx) {
    if (_messageEventListener == null) {
      _messageEventListener = _handleMessage;
    }
    final _backColor = Color.fromARGB(255, 0x61, 0x55, 0x32);
    //final url = 'http://smok95.woobi.co.kr/daumapi_flutter.html';
    final url = 'https://smok95.github.io/LogenCodeSearch/index_webapp.html';

    var count = 0;
    final appbar = AppBar(
      title: Text('도로명주소 검색'),
      backgroundColor: _backColor,
    );
    return Scaffold(
      appBar: appbar,
      body: EasyWebView(
          key: key,
          src: url,
          onLoaded: () {
            count++;

            if (count > 1) return;

            //print('onLoaded, count=${count}, key=${key} src=$url');
            html.window.addEventListener("message", _messageEventListener);
          }),
    );
  }

  void _handleMessage(html.Event event) {
    html.MessageEvent msg = event as html.MessageEvent;
    final message = msg?.data ?? null;
    _back(message);
  }

  void _back(String message) {
    html.window.removeEventListener("message", _messageEventListener);
    _messageEventListener = null;

    Navigator.of(context).maybePop(message);
  }
}
