import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final String selectedLanguage;
  AboutPage({required this.selectedLanguage});
  @override
  Widget build(BuildContext context) {
    String aboutTitle = '';
    String aboutContent = '';
    String contactInfo = '';
    switch (selectedLanguage) {
      case 'English':
        aboutTitle = 'About Us:';
        aboutContent =
            'We are committed to monitoring fish and water to ensure the health and sustainability of aquatic ecosystems. Our goal is to protect and preserve aquatic biodiversity for future generations.Come be a part of our journey , let us make this earth a better place to live';
        contactInfo = 'Contact us: example@example.com';
        break;
      case 'Telugu':
        aboutTitle = 'మా గురించి:';
        aboutContent =
            'మీకు నిత్యంగా నీటి మరియు చేపలను మంచిగా పరిశీలించడానికి అభిముఖంగా ఉన్నాము. మా లక్ష్యం భవిష్యత్తరాల కోసం జలచరాల జీవాత్మకత్వాన్ని రక్షించటానికి మరియు ప్రజాపూర్తికి కాయాంక్షలు నిర్వహిస్తున్నాము.రండి మన ప్రయాణంలో భాగం అవ్వండి, మనం ఈ భూమిని జీవించడానికి మంచి ప్రదేశంగా మార్చుకుందాం';
        contactInfo = 'మాతో సంప్రదించండి: example@example.com';
        break;
      case 'Hindi':
        aboutTitle = 'हमारे बारे में:';
        aboutContent =
            'हम फिश और पानी की निगरानी करने के लिए प्रतिबद्ध हैं ताकि जलीय पारिस्थितिकियों के स्वास्थ्य और संवेदनशीलता को सुनिश्चित किया जा सके। हमारा लक्ष्य भविष्य की पीढ़ियों के लिए जलीय जैव विविधता की संरक्षण और संरक्षण करना है। आइए हमारी यात्रा का हिस्सा बनें, आइए इस धरती को रहने के लिए एक बेहतर जगह बनाएं|';
        contactInfo = 'हमसे संपर्क करें: example@example.com';
        break;
      case 'Tamil':
        aboutTitle = 'எங்களை பற்றி:';
        aboutContent =
            'நாங்கள் மீன் மற்றும் நீரை கண்காணிக்க உங்களுக்கு அரசியற் படுகொலிகள் மற்றும் நீர்ச்சாரத்திற்கான நோக்கத்துடன் உள்ளோம். எங்கள் இலக்கு எடுக்க உடனடியாகும் நீர் உடல்மையை காத்திருப்பது, எங்கள் லக்ஷ்யம் எங்கள் பிறகுத் தரமான தாவரங்களின் பாதுகாப்புக்கு மருந்துச்சிகிச்சையைக் கடத்துவது.';
        contactInfo = 'நம்பரை அழைக்கவும்: example@example.com';
        break;
      case 'Kannada':
        aboutTitle = 'ನಮ್ಮ ಬಗ್ಗೆ:';
        aboutContent =
            'ನಾವು ಮೀನು ಮತ್ತು ನೀರಿನ ನಿಗಹಿತಗಳನ್ನು ಕಾಯುವುದರ ಮೂಲಕ ಜಲಚರ ಪರಿಸರದ ಆರೋಗ್ಯವನ್ನು ಮತ್ತು ಹೊಳೆಯುವ ಸಂತೃಪ್ತಿಯನ್ನು ಖಚಿತಪಡಿಸಲು ಬದ್ಧವಾಗಿದ್ದೇವೆ. ನಮ್ಮ ಉದ್ದೇಶವು ಮುಂದಿನ ತಲೆಮಾರಿನ ಪೀಡಿಗೆ ನೀರು ಜೀವ ವಿವಿಧತೆಯನ್ನು ರಕ್ಷಿಸುವುದು ಮತ್ತು ಉಳಿಸುವುದು.';
        contactInfo = 'ನಮ್ಮನ್ನು ಸಂಪರ್ಕಿಸಿ: example@example.com';
        break;
      default:
        aboutTitle = 'About Us:';
        aboutContent =
            'We are committed to monitoring fish and water to ensure the health and sustainability of aquatic ecosystems. Our goal is to protect and preserve aquatic biodiversity for future generations.';
        contactInfo = 'Contact us: example@example.com';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/k.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  aboutTitle,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  aboutContent,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Text(
                  contactInfo,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    home: AboutPage(selectedLanguage: 'English'), 
  ));
}

