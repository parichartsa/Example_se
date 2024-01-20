import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
              // ... Your other widgets ...
            ],
          ),
        ),
      ),
      // ... BottomNavigationBar goes here ...
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
}

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double bannerHeight = 100.0;

    return Container(
      height: bannerHeight,
      margin: EdgeInsets.all(10), // Add margin for spacing around the banner
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(10), // Rounded corners for the frame
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'แบนเนอร์ประจำวันนี้', // Replace with your desired text
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
