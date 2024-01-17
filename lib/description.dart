import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExamPreviewPage(),
    );
  }
}

class ExamPreviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Pre-Test ภาษาอังกฤษ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFEDE7F6), // The top right color
              Color(0xFFE1BEE7), // The bottom left color
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: 600), // Use appropriate max width for tablets
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ทดสอบประจำวัน',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: 8),
                Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black.withOpacity(0.1)),
                InfoTile(
                  icon: Icons.description, // Changed to paper icon
                  text: 'เวลาอีก 10 นาที',
                ),
                InfoTile(
                  icon: Icons.timer,
                  text: 'เวลาทำ 20 นาที',
                ),
                InfoTile(
                  icon: Icons.trending_up,
                  text: 'แบบทดสอบที่ผ่านมา 50%',
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo, // Button background color
                    onPrimary: Colors.white, // Button text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  ),
                  child: Text(
                    'เริ่มทำแบบทดสอบ',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoTile({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.black),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
