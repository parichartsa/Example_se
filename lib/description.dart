import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'test.dart';

void main() {
  runApp(DescriptionPage());
}

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExamPreviewPage(),
    );
  }
}

class ExamPreviewPage extends StatelessWidget {
  Future<void> getTest(BuildContext context, String subject) async {
    var url = Uri.parse('http://192.168.1.195:3001/api/exams/');

    // Convert Map to a JSON string
    var requestBody = jsonEncode({
      "subject": subject,
    });

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("getTest successful: $data");
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TestPage(data: data)),
      );
    } else {
      print("getTest failed");
    }
  }

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
          //ยังไม่ได้ดึง
          'Bio Pat2 62',
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
              Color(0xFFEDE7F6),
              Color(0xFFE1BEE7),
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
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
                  color: Colors.black.withOpacity(0.1),
                ),
                InfoTile(
                  icon: Icons.description,
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
                  onPressed: () {
                    getTest(context, "biology");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    onPrimary: Colors.white,
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
