import 'package:flutter/material.dart';
class PrecautionPage extends StatelessWidget {
  final String selectedLanguage;
  PrecautionPage({required this.selectedLanguage});
  @override
  Widget build(BuildContext context) {
    String title;
    String temperatureInfo;
    String co2Info;
    String turbidityInfo;
    String phInfo;
    String waterLevelInfo;
    switch (selectedLanguage) {
      case 'English':
        title = 'Precautions';
        temperatureInfo =
            'Maintaining optimal temperature in aquatic environments ensures organism survival by regulating metabolism and preventing harmful bacteria growth, crucial for ecosystem health and balance.';
        co2Info =
            'Monitoring CO2 levels helps ensure a healthy aquatic environment by preventing CO2 buildup, which can lead to acidification and harm aquatic life.';
        turbidityInfo =
            'Turbidity refers to the cloudiness or haziness of water caused by suspended particles. Monitoring turbidity is important to maintain water quality and clarity.';
        phInfo =
            'pH level indicates the acidity or alkalinity of water. Monitoring pH levels is crucial as it affects the health of aquatic life and the effectiveness of water treatment processes.';
        waterLevelInfo =
            'Maintaining proper water levels is important to ensure adequate oxygenation and circulation, preventing stress or suffocation of aquatic organisms.';
        break;
      case 'Telugu':
        title = 'ముందుజాగ్రత్తలు';
        temperatureInfo =
            'తగినంత ఆక్సిజనేషన్ మరియు ప్రసరణను నిర్ధారించడానికి సరైన నీటి స్థాయిలను నిర్వహించడం చాలా ముఖ్యం, నీటి జీవుల ఒత్తిడి లేదా ఊపిరాడకుండా చేస్తుంది.';
        co2Info =
            'జీవి మనుగడకు జల వాతావరణంలో సరైన ఉష్ణోగ్రతను నిర్వహించడం చాలా అవసరం. ఇది జీవక్రియను నియంత్రిస్తుంది, హానికరమైన బ్యాక్టీరియా పెరుగుదలను నిరోధిస్తుంది మరియు పర్యావరణ వ్యవస్థ ఆరోగ్యాన్ని నిర్ధారిస్తుంది. సరైన పరిధుల నుండి విచలనాలు జీవులపై ఒత్తిడిని కలిగిస్తాయి, జీవరసాయన ప్రతిచర్యలకు అంతరాయం కలిగిస్తాయి మరియు నీటి నాణ్యతను క్షీణింపజేస్తాయి, ఇది జల జీవితం మరియు మానవులపై ప్రభావం చూపుతుంది.';
        turbidityInfo =
            'సస్పెండ్ చేయబడిన కణాల కారణంగా నీటి యొక్క టర్బిడిటీ, మేఘావృతం లేదా పొగమంచు, నీటి నాణ్యత మరియు స్పష్టతను నిలబెట్టడానికి తప్పనిసరిగా పర్యవేక్షించబడాలి. వివిధ జల జీవావరణ వ్యవస్థలు మరియు త్రాగునీరు మరియు వినోద కార్యకలాపాల వంటి మానవ ఉపయోగాలకు సరైన టర్బిడిటీ స్థాయిలను నిర్వహించడం చాలా అవసరం.';
        phInfo =
            'pH స్థాయి నీటి ఆమ్లత్వం లేదా క్షారతను సూచిస్తుంది. నీటి జీవుల ఆరోగ్యం మరియు నీటి శుద్ధి ప్రక్రియల ప్రభావాన్ని ప్రభావితం చేసే pH స్థాయిలను పర్యవేక్షించడం చాలా ముఖ్యం.';
        waterLevelInfo =
            'తగినంత ఆక్సిజనేషన్ మరియు ప్రసరణను నిర్ధారించడానికి సరైన నీటి స్థాయిలను నిర్వహించడం చాలా ముఖ్యం, నీటి జీవుల ఒత్తిడి లేదా ఊపిరాడకుండా చేస్తుంది.';
        break;
      default:
        title = 'Precautions';
        temperatureInfo =
            'Maintaining the correct temperature is essential for the survival of aquatic organisms and to prevent the growth of harmful bacteria.';
        co2Info =
            'Monitoring CO2 levels helps ensure a healthy aquatic environment by preventing CO2 buildup, which can lead to acidification and harm aquatic life.';
        turbidityInfo =
            'Turbidity refers to the cloudiness or haziness of water caused by suspended particles. Monitoring turbidity is important to maintain water quality and clarity.';
        phInfo =
            'pH level indicates the acidity or alkalinity of water. Monitoring pH levels is crucial as it affects the health of aquatic life and the effectiveness of water treatment processes.';
        waterLevelInfo =
            'Maintaining proper water levels is important to ensure adequate oxygenation and circulation, preventing stress or suffocation of aquatic organisms.';
    }
     return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade900],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -100,
              left: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade100.withOpacity(0.2),
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              right: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade100.withOpacity(0.3),
                ),
              ),
            ),
            ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                SizedBox(height: 20.0),
                _buildPrecautionItem(
                  icon: Icons.thermostat_outlined,
                  title: 'Temperature',
                  description: temperatureInfo,
                ),
                SizedBox(height: 20.0),
                _buildPrecautionItem(
                  icon: Icons.cloud_outlined,
                  title: 'CO2',
                  description: co2Info,
                ),
                SizedBox(height: 20.0),
                _buildPrecautionItem(
                  icon: Icons.waves_outlined,
                  title: 'Turbidity',
                  description: turbidityInfo,
                ),
                SizedBox(height: 20.0),
                _buildPrecautionItem(
                  icon: Icons.analytics_outlined,
                  title: 'pH',
                  description: phInfo,
                ),
                SizedBox(height: 20.0),
                _buildPrecautionItem(
                  icon: Icons.waves,
                  title: 'Water Level',
                  description: waterLevelInfo,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrecautionItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 40.0,
              color: Colors.blue,
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              description,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PrecautionPage(selectedLanguage: 'English'), 
  ));
}

