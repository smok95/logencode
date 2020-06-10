import 'dart:convert';

import 'package:flutter/material.dart';

import 'code_list_view.dart';
import 'juso_page.dart';
import 'daum_address.dart';

void main() => runApp(LogenCodeApp());

class LogenCodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '로젠택배 지점코드 검색',
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(title: 'Home'),
        '/dorojuso': (_) => JusoPage(title: 'doro'),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _textEditor = TextEditingController();
  var _showClearBtn = false;
  var _codeListview = CodeListView();

  @override
  Widget build(BuildContext ctx) {
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
                Icons.search,
                color: _iconColor,
              ),
              onPressed: null),
          title: TextField(
            controller: _textEditor,
            onChanged: (val) {
              _search(val);
            },
            style: TextStyle(color: _textColor),
            decoration: InputDecoration(
                hintText: "검색어를 입력하세요...",
                hintStyle: TextStyle(color: _hintTextColor),
                border: InputBorder.none,
                suffixIcon: _showClearBtn
                    ? IconButton(
                        icon: Icon(Icons.clear, color: _iconColor),
                        onPressed: () {
                          _textEditor.clear();
                          _search('');
                        })
                    : null),
          )),
      body: _codeListview,
      /* 웹앱에서 다음API 페이지가 표시되지 않는 현상 , 2020.06.10
        원인파악, 귀찮으니 그냥 웹에서는 지원하지 않는걸로...
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton.extended(
            backgroundColor: _backColor,
            onPressed: () {
              Scaffold.of(context).hideCurrentSnackBar();

              Navigator.pushNamed(ctx, '/dorojuso').then((value) {
                _searchFromDaumAddress(context, value);
              });

              FocusScope.of(context).unfocus();
              print('press');
            },
            label: Text('도로명주소 검색'),
            icon: Icon(Icons.search));
      }),
      */
    );
  }

  void _searchFromDaumAddress(BuildContext context, String src) {
    if (src == null) return;

    Map<String, dynamic> data = jsonDecode(src);
    if (data == null) return null;

    var items = DaumAddress.convertFrom(data);

    String keyword = '';
    for (var item in items) {
      if (item == null || item.name.isEmpty) continue;
      if (_codeListview.filter(item.name) > 0) {
        keyword += item.name;
        if (keyword.length > 0) keyword += ' ';
      } else {
        break;
      }
    }
    _textEditor.text = keyword;
    _search(_textEditor.text);

    // 도로명주소
    String roadAddr = data['roadAddress'];
    if (roadAddr.isEmpty) roadAddr = data['autoRoadAddress'];

    // 지번주소
    String jibunAddr = data['jibunAddress'];
    if (jibunAddr.isEmpty) jibunAddr = data['autoJibunAddress'];

    final snackBar = SnackBar(
      action: SnackBarAction(
          label: "닫기",
          onPressed: () => Scaffold.of(context).hideCurrentSnackBar()),
      duration: Duration(seconds: 15),
      content: Wrap(
        children: <Widget>[
          new ListTile(
              title: Text('검색결과'),
              subtitle: Text("도로명: ${roadAddr}\n지번: ${jibunAddr}"),
              onTap: () => {}),
        ],
      ),
    );

    // Find the Scaffold in the widget tree and use
    // it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _search(String keyword) {
    //print("'$keyword'");

    var showClearBtn = keyword.isEmpty ? false : true;

    setState(() {
      _codeListview.filter(keyword);

      if (showClearBtn != _showClearBtn) {
        _showClearBtn = showClearBtn;
      }
    });
  }
}
