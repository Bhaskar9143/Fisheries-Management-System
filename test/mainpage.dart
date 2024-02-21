import 'package:flutter/material.dart';
import 'dart:math';
import 'about.dart';
import 'login.dart';
import 'anal.dart';
import 'precautions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MainPage(username: 'User', selectedLanguage: 'English'),
    );
  }
}
class MainPage extends StatefulWidget {
  final String username;
  final String selectedLanguage;
  MainPage({required this.username, required this.selectedLanguage});
  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  double _textSize = 20.0;
  bool _isDarkMode = false;
  int _feedbackRating = 0;
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();
  Color getColor(String readingName, double value) {
    final Map<String, double> restrictedValues = {
      'Temperature': 25.0,
      'pH': 7.0,
      'Turbidity': 5.0,
      'CO2': 10.0,
      'ORP': 400.0,
      'OD': 3.0,
    };
    double restrictedValue = restrictedValues[readingName]!;
    return value < restrictedValue ? Colors.red : Colors.green;
  }
  void analyze(String language) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnalPage(language: language),
      ),
    );
  }
  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Feedback"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Rate our app:"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= 5; i++)
                    IconButton(
                      icon: Icon(
                        _feedbackRating < i ? Icons.star_border : Icons.star,
                        color: Colors.yellow,
                      ),
                      onPressed: () {
                        setState(() {
                          _feedbackRating = i;
                        });
                      },
                    ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Submit"),
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
        title: Text('Main Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/U.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hello, ${widget.username}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AboutPage(selectedLanguage: widget.selectedLanguage),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.masks),
              title: Text('Precautions'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrecautionPage(
                        selectedLanguage: widget.selectedLanguage),
                  ),
                );
              },
            ),
            SwitchListTile(
              title: Text(_isDarkMode ? 'Dark Mode' : 'Light Mode'),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
                _showFeedbackDialog();
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginPage(selectedLanguage: widget.selectedLanguage),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _isDarkMode ? Colors.black87 : Colors.white,
              Colors.grey.shade200
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Readings:',
              style: TextStyle(
                fontSize: _textSize,
                color: _isDarkMode ? Colors.white : Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: databaseReference.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.snapshot.value != null) {
                    Map<dynamic, dynamic> values =
                        snapshot.data!.snapshot.value;
                    List<Widget> readingWidgets = values.entries.map((entry) {
                      String readingName = entry.key;
                      double value = entry.value.toDouble();
                      IconData icon;
                      switch (readingName) {
                        case 'Temperature':
                          icon = Icons.thermostat_outlined;
                          break;
                        case 'pH':
                          icon = Icons.analytics_outlined;
                          break;
                        case 'Turbidity':
                          icon = Icons.waves_outlined;
                          break;
                        case 'CO2':
                          icon = Icons.cloud_outlined;
                          break;
                        case 'ORP':
                          icon = Icons.flash_on_outlined;
                          break;
                        case 'OD':
                          icon = Icons.waves;
                          break;
                        default:
                          icon = Icons.error_outline;
                      }
                      Color color = getColor(readingName, value);
                      String sensorName =
                          sensorNames[readingName]![widget.selectedLanguage]!;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            icon,
                            color: color,
                            size: 28,
                          ),
                        ),
                        title: Text(
                          '$sensorName: ${value.toStringAsFixed(2)}',
                          style: TextStyle(color: color, fontSize: 18),
                        ),
                        onTap: () {
                          analyze(widget.selectedLanguage);
                        },
                      );
                    }).toList();
                    return ListView.builder(
                      itemCount: readingWidgets.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: readingWidgets[index],
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          analyze(widget.selectedLanguage);
        },
        child: Icon(Icons.analytics_outlined),
      ),
      backgroundColor: _isDarkMode ? Colors.black : Colors.white,
    );
  }
}
