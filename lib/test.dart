import 'dart:async';
import 'package:flutter/material.dart';


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
    return MaterialApp(
      home: Scaffold(
        body: QuizPage(data: data),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final Map<String, dynamic> data;

  QuizPage({Key? key, required this.data}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int? _selectedAnswer;
  bool isBookmarked = false;
  int currentQuestionIndex = 0;
  List<int?> answerSheet = List<int?>.filled(10, null);

  Duration _duration = const Duration(minutes: 59, seconds: 59);
  late Timer _timer;

  String get currentQuestionText =>
      widget.data['exam']['questions'][currentQuestionIndex]['question_text'];
  List<String> get currentOptions => List<String>.from(
      widget.data['exam']['questions'][currentQuestionIndex]['options']);
  int get totalQuestionIndex => widget.data['exam']['questions'].length;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _duration -= const Duration(seconds: 1);
        });
      }
    });
  }

  String getFormattedTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(_duration.inMinutes.remainder(60))}:${twoDigits(_duration.inSeconds.remainder(60))}";
  }

  void _submitAnswer() {
    if (_selectedAnswer != null) {
      // Add the selected answer (+1 to start from 1)
      answerSheet[currentQuestionIndex] = _selectedAnswer!;

      if (currentQuestionIndex < totalQuestionIndex - 1) {
        setState(() {
          currentQuestionIndex++;
          _selectedAnswer = answerSheet[currentQuestionIndex];
        });
      } else {
        // If it's the last question, navigate to the result page
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Testpage2(answerSheet: answerSheet)));
      }
    }
  }

  Widget _buildOption(String option, int index) {
    bool isSelected = _selectedAnswer == index;
    bool isAnswered = answerSheet[currentQuestionIndex] != null;

    return GestureDetector(
      onTap: () {
        if (!isAnswered) {
          setState(() {
            _selectedAnswer = index;
          });
        }
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.amber.withOpacity(0.4)
              : isAnswered
                  ? Colors.grey.withOpacity(0.4)
                  : Colors.white,
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
            style: TextStyle(
              color: isSelected || isAnswered ? Colors.black : Colors.black,
            ),
          ),
          value: index,
          groupValue: _selectedAnswer,
          onChanged: (int? value) {
            if (!isAnswered) {
              setState(() {
                _selectedAnswer = value;
              });
            }
          },
          activeColor: Colors.amber[700],
          dense: false,
          contentPadding: EdgeInsets.symmetric(
              horizontal: 16, vertical: 10), // Adjust padding as needed
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLastQuestion = currentQuestionIndex == totalQuestionIndex - 1;
    String buttonLabel = isLastQuestion ? 'สิ้นสุด' : 'ถัดไป';
    bool isFirstQuestion = currentQuestionIndex == 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          // Replace with your title
          'Bio Pat2 62',
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
                // Show question number and total questions
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.book, size: 24.0),
                    SizedBox(width: 8.0),
                    Text(
                      '${currentQuestionIndex + 1}/${totalQuestionIndex}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // Show time and bookmark button
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
            // Show the question
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: Colors.black.withOpacity(0.05), width: 1.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                currentQuestionText,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
            // Show answer options
            ...currentOptions
                .asMap()
                .entries
                .map((entry) => _buildOption(entry.value, entry.key))
                .toList(),
            const SizedBox(height: 24),
            // Show Back and Next/Finish Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isFirstQuestion)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _backAction,
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(70, 70, 122, 1),
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
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLastQuestion) {
                        // Handle finish action
                        // For example, navigate to the result page
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                Testpage2(answerSheet: answerSheet)));
                      } else {
                        // Handle next question action
                        _submitAnswer();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(70, 70, 122, 1),
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(buttonLabel, style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _backAction() {
    if (currentQuestionIndex > 0) {
      setState(() {
        bool isAnswered = answerSheet[currentQuestionIndex - 1] != null;
      
      if (isAnswered) {
        // If the current question has been answered, set _selectedAnswer to the previous answer
        _selectedAnswer = answerSheet[currentQuestionIndex]! - 1;
      } else {
        // If the current question has not been answered, set _selectedAnswer to null
        _selectedAnswer = null;
      }
        currentQuestionIndex--;
        _selectedAnswer = answerSheet[currentQuestionIndex];
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class Testpage2 extends StatelessWidget {
  final List<int?> answerSheet;

  const Testpage2({Key? key, required this.answerSheet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Completed Quiz',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(
              'Your Answers: ${answerSheet.where((answer) => answer != null).join(", ")}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}