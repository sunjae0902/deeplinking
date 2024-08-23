import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Link Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppLinks _appLinks = AppLinks();
  String _linkMessage = 'Waiting for deep link...';

  @override
  void initState() {
    super.initState();

    // 앱이 시작될 때 받은 URL 처리
    _appLinks.getInitialLink().then((uri) {
      _handleDeepLink(uri);
    });

    // 앱이 실행 중일 때 도착하는 URL 처리
    _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri? uri) {
    if (uri != null) { // 경로에 따라 다른 화면으로 네비게이션
      if (uri.pathSegments.isNotEmpty) {
        final path = uri.pathSegments.first;
        if (path == 'page1') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page1Screen()),
          );
        } else if (path == 'page2') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Page2Screen()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text(_linkMessage),
      ),
    );
  }
}

class Page1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: Center(
        child: Text('Welcome to Page 1!'),
      ),
    );
  }
}

class Page2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(
        child: Text('Welcome to Page 2!'),
      ),
    );
  }
}
