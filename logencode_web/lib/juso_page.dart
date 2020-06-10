import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class JusoPage extends StatefulWidget {
  final String title;
  JusoPage({Key key, this.title}) : super(key: key);

  _JusoPageState createState() => _JusoPageState();
}

class _JusoPageState extends State<JusoPage> {
  final _webviewPlugin = FlutterWebviewPlugin();
  @override
  Widget build(BuildContext ctx) {
    return _buildWebview(ctx);

    final _backColor = Color.fromARGB(255, 0x61, 0x55, 0x32);
    final _iconColor = Colors.brown[100];
    final _hintTextColor = _iconColor;
    final _textColor = Colors.white;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _backColor, //Colors.brown,
        titleSpacing: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: _iconColor,
          ),
          onPressed: () {
            Navigator.pop(ctx);
          },
        ),
        title: Text('도로명주소 검색'),
      ),
      body: Text('this is body'),
    );
  }

  Widget _buildWebview(BuildContext ctx) {
    final _backColor = Color.fromARGB(255, 0x61, 0x55, 0x32);
    //final url = 'http://smok95.woobi.co.kr/daumapi_flutter.html';
    final url = 'https://smok95.github.io/LogenCodeSearch';
    return WebviewScaffold(
      url: url,
      appBar: AppBar(
        title: const Text('도로명주소 검색'),
        backgroundColor: _backColor,
      ),
      withZoom: true,
      withLocalStorage: true,
      javascriptChannels: Set.from([
        JavascriptChannel(
          name: 'flutter',
          onMessageReceived: (message) {
            Navigator.pop(ctx, message.message);
            //_webviewPlugin.close();
          },
        ),
      ]),
      hidden: true,
      initialChild: Container(
        color: Colors.grey,
        child: const Center(
          child: Text('연결중...'),
        ),
      ),
    );
  }
}
