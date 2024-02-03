import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verify Your Email Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VerifyEmailScreen(),
    );
  }
}

class VerifyEmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Your Email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email,
              size: 120.0,
              color: Colors.amber,
            ),
            SizedBox(height: 24.0),
            Text(
              'Please Enter The 4 Digit Code Sent To amanullah28799@gmail.com',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => _buildCodeNumberBox()),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text('Verify'),
              onPressed: () {
                // Implement verify functionality
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // background
                onPrimary: Colors.white, // foreground
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeNumberBox() {
    return Container(
      width: 60,
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
          hintText: '_',
          hintStyle: TextStyle(fontSize: 30, color: Colors.black),
          counterText: "",
        ),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30, letterSpacing: 24),
        keyboardType: TextInputType.number,
        maxLength: 1,
      ),
    );
  }
}
