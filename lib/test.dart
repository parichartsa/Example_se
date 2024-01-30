import 'dart:async';
import 'package:flutter/material.dart';
import 'test2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const TestPage(
    data: null,
  ));
}

class TestPage extends StatelessWidget {
  final dynamic data;

  const TestPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Your TestPage implementation using the 'data' parameter
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: Center(
        child: Text('Data from ExamPreviewPage: $data'),
      ),
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
  Duration _duration = const Duration(minutes: 59, seconds: 32);
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
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_duration.inSeconds == 0) {
        _timer.cancel();
      } else {
        setState(() {
          _duration -= const Duration(seconds: 1);
        });
      }
    });
  }

  void _submitAnswer() {
    if (_selectedAnswer != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Testpage2()),
      );
    }
  }

  Widget _buildOption(String option, int index) {
    bool isSelected = _selectedAnswer == index;
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color:
            isSelected ? const Color.fromRGBO(255, 194, 18, 0.4) : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isSelected
              ? const Color.fromRGBO(255, 194, 18, 0.2)
              : Colors.black.withOpacity(0.05),
          width: 1.0,
        ),
      ),
      child: RadioListTile<int>(
        title: Text(
          option,
          style: TextStyle(color: isSelected ? Colors.black : Colors.black),
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
        title: const Text(
          'Pre-test ภาษาอังกฤษ',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.book, size: 24.0),
                    SizedBox(width: 8.0),
                    Text(
                      '1/10',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.black54, width: 1.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.timer, size: 24.0),
                          const SizedBox(width: 8.0),
                          Text(
                            getFormattedTime(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0),
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
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 24),
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
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            ...options
                .asMap()
                .entries
                .map((entry) => _buildOption(entry.value, entry.key))
                .toList(),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _selectedAnswer != null ? _submitAnswer : null,
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(
                      70, 70, 122, 1), // Custom color using RGB values
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Row(
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
      ),
    );
  }

  Future<void> fetchBiologyData() async {
    var url = Uri.parse(
        'http://localhost:3001/api/exams/'); // Adjust the URL if needed

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // Handle the fetched data
        print(data);
      } else {
        // Handle the error
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Handle the exception
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
