import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScorePage(),
    );
  }
}

class ScorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Image asset should be added to your project in the appropriate directory
    final String handImagePath = 'assets/hand_image.png';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Pre-test ภาษาอังกฤษ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFB74D), Color(0xFFFFE0B2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 24),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'คุณได้คะแนน 30%',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Image.asset(
                          handImagePath, // Make sure you add the image asset to your project
                          width: MediaQuery.of(context).size.width *
                              0.6, // Adjust the size accordingly
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  StatisticCard(),
                  Spacer(),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
              ),
              child: Column(
                children: [
                  Text(
                    '🌟 หัวข้อของคุณ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                      fontSize: 18,
                    ),
                  ),
                  Divider(color: Colors.black26),
                  CategoryScore('Grammar', 0.25),
                  CategoryScore('Vocabulary', 0.25),
                  CategoryScore('Conversation', 0.25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatisticItem('10 ข้อผิด', Icons.close, Colors.red),
            StatisticItem('03 ข้อ', Icons.pause_circle_filled, Colors.amber),
            StatisticItem('07 ข้อ', Icons.check_circle, Colors.green),
          ],
        ),
      ),
    );
  }
}

class StatisticItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  StatisticItem(this.label, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}

class CategoryScore extends StatelessWidget {
  final String category;
  final double score;

  CategoryScore(this.category, this.score);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(category)),
          Expanded(
            flex: 7,
            child: LinearProgressIndicator(
              value: score,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('${(score * 100).toInt()}%'),
          ),
        ],
      ),
    );
  }
}
