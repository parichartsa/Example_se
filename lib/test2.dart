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
  bool isBookmarked = false;
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
    // Implement your submit answer logic here
  }

  void _backAction() {
    // Implement your back action logic here
  }

  Widget _buildOption(String option, int index) {
    bool isSelected = _selectedAnswer == index;
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isSelected ? Color.fromARGB(255, 228, 176, 5) : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isSelected
              ? Color.fromARGB(255, 228, 176, 5)
              : Colors.black.withOpacity(0.05),
          width: 1.0,
        ),
      ),
      child: RadioListTile<int>(
        title: Text(
          option,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
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
        title: Text(
          'Pre-test ภาษาอังกฤษ',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timer and Bookmark Widgets
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Question Counter Widget
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.book, size: 24.0),
                    SizedBox(width: 8.0),
                    Text(
                      '2/10',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // Timer and Bookmark Row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Timer Container
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
                          Icon(Icons.timer, size: 24.0),
                          SizedBox(width: 8.0),
                          Text(
                            getFormattedTime(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.0),
                    // Bookmark Icon
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isBookmarked = !isBookmarked;
                        });
                      },
                      child: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        size: 24.0,
                        color: isBookmarked ? Colors.amber : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),
            // Question Container
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black.withOpacity(0.05),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                question,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            // Options List
            ...options
                .asMap()
                .entries
                .map((entry) => _buildOption(entry.value, entry.key))
                .toList(),
            SizedBox(height: 24),
            // Back and Next Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: _backAction,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(width: 10),
                        Text('ย้อนกลับ', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Next Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedAnswer != null ? _submitAnswer : null,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ถัดไป', style: TextStyle(fontSize: 18)),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
