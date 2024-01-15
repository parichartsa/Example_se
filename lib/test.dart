import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int? _selectedAnswer;
  final String question =
      'The boy claimed that the pencil box belonged to him, but soon everybody found out that he _____.';
  final List<String> options = [
    'is lying',
    'tells a lie',
    'has told a lie',
    'had told a lie'
  ];

  // Countdown Timer
  Duration _duration = Duration(minutes: 59, seconds: 32);
  late Timer _timer;

  String getFormattedTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(_duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(_duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_duration.inSeconds == 0) {
        _timer.cancel();
      } else {
        setState(() {
          _duration -= Duration(seconds: 1);
        });
      }
    });
  }

  void _submitAnswer() {
    if (_selectedAnswer != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You selected: ${options[_selectedAnswer!]}'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildOption(String option, int index) {
    bool isSelected = _selectedAnswer == index;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? Color.fromARGB(255, 228, 176, 5)
            : Colors.transparent, // Fix here
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isSelected
              ? Color.fromARGB(255, 228, 176, 5) 
              : Color.fromARGB(255, 0, 0, 0), // Fix here
          width: 1.0,
        ),
      ),
      child: RadioListTile<int>(
        title: Text(option),
        value: index,
        groupValue: _selectedAnswer,
        onChanged: (int? value) {
          setState(() {
            _selectedAnswer = value;
          });
        },
        activeColor: Colors.amber[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pre-test ทบทวนวิชา'),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Index and Timer in the same row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.book, size: 24.0), // Book icon
                    SizedBox(width: 8.0),
                    Text(
                      'Question 1/10',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // Timer and Bookmark in the same container
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.black54, width: 1.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.timer, size: 24.0), // Timer icon
                      SizedBox(width: 8.0),
                      Text(
                        getFormattedTime(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8.0),
                      Icon(Icons.bookmark_border, size: 24.0), // Bookmark icon
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              question,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            // Options
            ...options
                .asMap()
                .entries
                .map((entry) => _buildOption(entry.value, entry.key))
                .toList(),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedAnswer != null ? _submitAnswer : null,
                child: Text(
                  'ส่งคำตอบ', // "Submit" in Thai
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple, // Button background color
                  onPrimary: Colors.white, // Button text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }
}
