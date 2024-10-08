import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              _logo(isDarkMode),
              Expanded(child: _content(isDarkMode)), // Use Expanded to fit the remaining space
              _bottomImages(isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo(bool isDarkMode) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [Colors.grey[850]!, Colors.grey[900]!]
              : [Color(0xFF5C5B5B), Color(0xFF023047)],
          stops: [0.1, 0.3],
          begin: AlignmentDirectional(-1, -1),
          end: AlignmentDirectional(1, 1),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.transparent, Colors.black]
                : [Colors.transparent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0), // Adjust top padding as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.lock_reset,
                color: isDarkMode ? Colors.amber : Color(0xFF8ecae6),
                size: 100.0,
              ),
              SizedBox(height: 20.0), // Added spacing
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 10.0), // Added spacing
              Text(
                "Enter your email to reset your password.",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Roboto',
                  color: isDarkMode ? Colors.grey[300] : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Email',
              labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: isDarkMode ? Colors.white54 : Colors.black54),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: isDarkMode ? Colors.white : Colors.blue),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isDarkMode ? Colors.grey[800] : Color(0xFF5C5B5B).withOpacity(0.8),
              elevation: 0,
              minimumSize: Size(250, 60), // Button size
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              // Add password reset logic here
            },
            child: Text(
              'Send Reset Link',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          TextButton(
            onPressed: () {
              // Navigate back to the login page
              Navigator.pop(context);
            },
            child: Text(
              'Remember your password? Sign In',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.grey[300] : Color(0xFF5C5B5B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomImages(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Powered by:',
              style: TextStyle(
                fontSize: 16.0,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                Image.asset(
                  'assets/images/Logo_Universitas_Brawijaya.png',
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 30),
                Image.asset(
                  'assets/images/logo_IMS.png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(width: 10),
                Image.asset(
                  'assets/images/logo_rispro.png',
                  width: 80,
                  height: 80,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
