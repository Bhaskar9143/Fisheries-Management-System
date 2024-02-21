import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'login.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('te', 'IN'),
        const Locale('hi', 'IN'),
        const Locale('ta', 'IN'),
        const Locale('kn', 'IN'),
      ],
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  String selectedLanguage = 'en';
  void _onLanguageChanged(String? value) {
    if (value != null) {
      setState(() {
        selectedLanguage = value;
      });
    }
  }
  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(selectedLanguage: selectedLanguage),
      ),
    );
  }
  void _navigateToVideoPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPage(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/purefin.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: _navigateToLogin,
              child: Text(
                selectedLanguage == 'en'
                    ? 'Get Started'
                    : selectedLanguage == 'te'
                        ? 'ప్రారంభం చేయండి'
                        : selectedLanguage == 'hi'
                            ? 'शुरू करें'
                            : selectedLanguage == 'ta'
                                ? 'தொடங்கவும்'
                                : selectedLanguage == 'kn'
                                    ? 'ಪ್ರಾರಂಭಿಸಿ'
                                    : 'Get Started',
              ),
            ),
          ),
          Positioned(
            top: 50.0,
            right: 20.0,
            child: DropdownButton<String>(
              value: selectedLanguage,
              onChanged: _onLanguageChanged,
              items: <String>[
                'en',
                'te',
                'hi',
                'ta',
                'kn',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 50.0,
            left: 20.0,
            child: ElevatedButton(
              onPressed: _navigateToVideoPage,
              child: Text('Watch Video'),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: Center(
        child: Text('Video will be displayed here'),
      ),
    );
  }
}
