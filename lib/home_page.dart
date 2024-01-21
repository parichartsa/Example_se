import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage_demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.account_circle, size: 40),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'สวัสดีวิชากร',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'มาเริ่มทำข้อสอบกันเถอะ',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BannerWidget(),
              SizedBox(height: 20),
              Container(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildCategory('En', Icons.science, Colors.deepPurple),
                    SizedBox(width: 8),
                    _buildCategory(
                        'ประเมิน', Icons.auto_awesome_mosaic, Colors.amber),
                    SizedBox(width: 8),
                    _buildCategory(
                        'สุขภาพ', Icons.favorite_border, Colors.pink),
                    SizedBox(width: 8),
                    _buildCategory('สมอง', Icons.biotech, Colors.lightBlue),
                    SizedBox(width: 8),
                    _buildCategory('คณิตศาสตร์', Icons.calculate, Colors.green),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoCard(
                      'ข้อสอบแนะนำ',
                      'ข้อสอบแนะนำสำหรับคุณ',
                      Icons.book,
                      Colors.pink.shade100,
                      Colors.pink.shade900,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoCard(
                      'หลักสูตรเร่งรัด',
                      'หลักสูตรเร่งรัดสำหรับเรียนในวันหยุด',
                      Icons.access_alarm,
                      Colors.blue.shade100,
                      Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SecondBannerWidget(), // Second banner placed here
              // Additional widgets can be added here
            ],
          ),
        ),
      ),
      // BottomNavigationBar can be added here
    );
  }

  Widget _buildCategory(String text, IconData icon, Color color) {
    return Container(
      width: 69,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String subtitle, IconData icon,
      Color bgColor, Color textColor) {
    return Container(
      height: 200,
      child: Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(icon, size: 28, color: textColor),
              Text(title,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
              Text(subtitle,
                  style: TextStyle(
                      color: textColor.withOpacity(0.7), fontSize: 12)),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: Text('เริ่มต้น'),
                style: ElevatedButton.styleFrom(
                  primary: bgColor,
                  onPrimary: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFFE0DFFD),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          'แบนเนอร์ประจำวันนี้',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class SecondBannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFFDFFDE0), // Green color for the second banner
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          '-',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
