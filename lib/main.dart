import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        textTheme:
            GoogleFonts.interTextTheme(), // Replace with your custom font
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Pre-Test',
      'icon': Icons.edit,
      'color': Color(0xFF7766C6).withOpacity(0.8),
    },
    {
      'title': 'O-NET',
      'icon': Icons.book,
      'color': Color(0xFFE0DFFD),
    },
    {
      'title': 'GAT',
      'icon': Icons.backpack,
      'color': Color(0xFFF9B0C3),
    },
    {
      'title': 'วิชาสามัญ',
      'icon': Icons.school,
      'color': Color(0xABFFC212),
    },
  ];

  final TextStyle cardTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('ภาษาอังกฤษ', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(119, 102, 198, 0.4), // Purple
              Color.fromRGBO(249, 176, 195, 0.4), // Pink
              Color.fromRGBO(255, 194, 18, 0.4), // Yellow
              Colors.white, // White
            ],
            stops: [0.25, 0.5, 0.75, 1.0],
          ),
        ),
        child: SafeArea(
          child: GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildCard(
                items[index]['title'],
                items[index]['icon'],
                cardTextStyle,
                items[index]['color'],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, IconData iconData, TextStyle textStyle,
      Color backgroundColor) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(iconData, size: 48, color: textStyle.color),
          SizedBox(height: 8),
          Text(title, style: textStyle),
        ],
      ),
    );
  }
}
