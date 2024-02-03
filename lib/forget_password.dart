import 'package:flutter/material.dart';

void main() {
  runApp(ForgetPassword());
}

class ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forgot Password Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 120.0,
              color: Colors.amber,
            ),
            SizedBox(height: 24.0),
            Text(
              'Please Enter Your Email Address To Receive a Verification Code.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter your email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text('Send'),
              onPressed: () {
                // Implement send functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
