import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
enum Parameter { temperature, pH, turbidity, ORP, waterLevel }
class AnalPage extends StatefulWidget {
  final String language;
  AnalPage({required this.language});
  @override
  _AnalPageState createState() => _AnalPageState();
}
class _AnalPageState extends State<AnalPage> {
  late DatabaseReference _databaseReference;
  late StreamSubscription<Event> _dataSubscription;
  List<double> temperatureValues = [];
  List<double> pHValues = [];
  List<double> turbidityValues = [];
  List<double> ORPValues = [];
  List<double> waterLevelValues = [];
  late double currentValue;
  late Parameter selectedParameter;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((_) {
      _databaseReference = FirebaseDatabase.instance.reference();
      _dataSubscription =
          _databaseReference.child('sensorData').onValue.listen((event) {
        var data = event.snapshot.value;
        temperatureValues = List.generate(20, (index) => data['temperature']);
        pHValues = List.generate(20, (index) => data['pH']);
        turbidityValues = List.generate(20, (index) => data['turbidity']);
        ORPValues = List.generate(20, (index) => data['ORP']);
        waterLevelValues = List.generate(20, (index) => data['waterLevel']);
        setState(() {}); // Update UI when data changes
      });
    });
    currentValue = temperatureValues.last;
    selectedParameter = Parameter.temperature;
  }
  @override
  void dispose() {
    _dataSubscription.cancel();
    super.dispose();
  }
  IconData getParameterIcon() {
    switch (selectedParameter) {
      case Parameter.temperature:
        return Icons.thermostat;
      case Parameter.pH:
        return Icons.opacity;
      case Parameter.turbidity:
        return Icons.waves;
      case Parameter.ORP:
        return Icons.bolt;
      case Parameter.waterLevel:
        return Icons.waves;
    }
  }
  List<double> getSelectedValues() {
    switch (selectedParameter) {
      case Parameter.temperature:
        return temperatureValues;
      case Parameter.pH:
        return pHValues;
      case Parameter.turbidity:
        return turbidityValues;
      case Parameter.ORP:
        return ORPValues;
      case Parameter.waterLevel:
        return waterLevelValues;
    }}
  @override
  Widget build(BuildContext context) {
    List<double> selectedValues = getSelectedValues();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.language == 'English'
              ? 'Parameter Analysis'
              : 'పారామెటర్ విశ్లేషణ',
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.blueGrey.shade800],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.language == 'English' ? 'Parameter' : 'పారామెటర్',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xffffffff)),
                  gradient: LinearGradient(
                    colors: [Color(0xdd010000), Colors.blueGrey.shade800],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(getParameterIcon(),
                          size: 40, color: Color(0xfff5f0f0)),
                      SizedBox(width: 20),
                      Expanded(
                        child: DropdownButton<Parameter>(
                          value: selectedParameter,
                          onChanged: (newValue) {
                            setState(() {
                              selectedParameter = newValue!;
                            });
                          },
                          items: Parameter.values.map((param) {
                            return DropdownMenuItem<Parameter>(
                              value: param,
                              child: Text(
                                param.toString().split('.').last.toUpperCase(),
                                style: TextStyle(color: Color(0xff0c66ce)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: selectedValues.length.toDouble() - 1,
                    minY: 0,
                    maxY: selectedValues.reduce(max),
                    lineBarsData: [
                      LineChartBarData(
                        spots: selectedValues.asMap().entries.map((entry) {
                          return FlSpot(entry.key.toDouble(), entry.value);
                        }).toList(),
                        colors: [Colors.blue],
                        isCurved: true,
                        belowBarData: BarAreaData(show: false),
                        dotData: FlDotData(show: false),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(showTitles: false),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(getParameterIcon(),
                        size: 40,
                        color: Colors.white),
                    SizedBox(width: 20),
                    Text(
                      selectedParameter == Parameter.temperature
                          ? 'Current Temperature: ${currentValue.toStringAsFixed(2)} °C'
                          : selectedParameter == Parameter.pH
                              ? 'Current pH: ${currentValue.toStringAsFixed(2)}'
                              : selectedParameter == Parameter.turbidity
                                  ? 'Current Turbidity: ${currentValue.toStringAsFixed(2)} NTU'
                                  : selectedParameter == Parameter.ORP
                                      ? 'Current ORP: ${currentValue.toStringAsFixed(2)} mV'
                                      : 'Current Water Level: ${currentValue.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(home: AnalPage(language: 'English')));
}
