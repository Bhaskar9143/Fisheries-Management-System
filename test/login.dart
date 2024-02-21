import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'mainpage.dart'; 
class LoginPage extends StatefulWidget {
  final String selectedLanguage;
  LoginPage({required this.selectedLanguage});
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    Box userDataBox = Hive.box('userData');
    String? storedUsername = userDataBox.get('username');
    String? storedPassword = userDataBox.get('password');
    if (username == storedUsername && password == storedPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            selectedLanguage: widget.selectedLanguage,
            username: username,
          ),
        ),
      );
    } else {
      _showAlertDialog('Invalid', 'Invalid username or password.');
    }
  }

  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
            content,
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.selectedLanguage == 'English'
              ? 'Login'
              : widget.selectedLanguage == 'Telugu'
                  ? 'లాగిన్'
                  : widget.selectedLanguage == 'Hindi'
                      ? 'लॉग इन करें'
                      : widget.selectedLanguage == 'Tamil'
                          ? 'உள்நுழை'
                          : widget.selectedLanguage == 'Kannada'
                              ? 'ಲಾಗಿನ್ ಮಾಡಿ'
                              : 'Login',
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "assets/sea.jpg"), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: widget.selectedLanguage == 'English'
                        ? 'Username'
                        : widget.selectedLanguage == 'Telugu'
                            ? 'యూజర్‌నేమ్'
                            : widget.selectedLanguage == 'Hindi'
                                ? 'उपयोगकर्ता नाम'
                                : widget.selectedLanguage == 'Tamil'
                                    ? 'பயனர்பெயர்'
                                    : widget.selectedLanguage == 'Kannada'
                                        ? 'ಬಳಕೆದಾರ ಹೆಸರು'
                                        : 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: widget.selectedLanguage == 'English'
                        ? 'Password'
                        : widget.selectedLanguage == 'Telugu'
                            ? 'పాస్‌వర్డ్'
                            : widget.selectedLanguage == 'Hindi'
                                ? 'पासवर्ड'
                                : widget.selectedLanguage == 'Tamil'
                                    ? 'கடவுச்சொல்'
                                    : widget.selectedLanguage == 'Kannada'
                                        ? 'ಪಾಸ್‌ವರ್ಡ್'
                                        : 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    widget.selectedLanguage == 'English'
                        ? 'Login'
                        : widget.selectedLanguage == 'Telugu'
                            ? 'లాగిన్'
                            : widget.selectedLanguage == 'Hindi'
                                ? 'लॉग इन करें'
                                : widget.selectedLanguage == 'Tamil'
                                    ? 'உள்நுழை'
                                    : widget.selectedLanguage == 'Kannada'
                                        ? 'ಲಾಗಿನ್ ಮಾಡಿ'
                                        : 'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
