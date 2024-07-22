import 'package:flutter/material.dart';
import 'homePage.dart';
import 'regist.dart';
import 'forgetpass.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: _page(isDarkMode),
        ),
      ),
    );
  }

  Widget _page(bool isDarkMode) {
    return Column(
      children: [
        Expanded(flex: 3, child: _logo(isDarkMode)),
        Expanded(flex: 4, child: _account(isDarkMode)),
        _bottomImages(isDarkMode),
      ],
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sunny_snowing,
              color: isDarkMode ? Colors.amber : Color(0xFF8ecae6),
              size: 100.0,
            ),
            Text(
              "Sign In",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            Text(
              "Use the account below to sign in.",
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Roboto',
                color: isDarkMode ? Colors.grey[300] : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _account(bool isDarkMode) {
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
              labelText: 'Username',
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
          SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: 'Password',
              labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            obscureText: _obscureText,
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
              );

            },
            child: Text(
              'Forget Password',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.grey[300] : Color(0xFF5C5B5B),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Text(
              'Register',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Color(0xFF5C5B5B),
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
                Image.asset(
                  'assets/images/Logo_Universitas_Brawijaya.png',
                  width: 40,
                  height: 40,
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
