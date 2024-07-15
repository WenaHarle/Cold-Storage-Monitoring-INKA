import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CO2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5C5B5B), // Keep AppBar background color
        title: Text(
          'CO₂',
          style: TextStyle(
            color: Colors.white, // Set AppBar title color to white
          ),
        ),
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView( // Add SingleChildScrollView to enable scrolling
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
            children: [
              const Text(
                "Real Time",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5C5B5B),
                ),
              ),
              const Text(
                "Sensor 1",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5C5B5B),
                ),
              ),
              const SizedBox(height: 10), // Add spacing between text and WebView
              Container(
                width: double.infinity, // Set desired width
                height: 300, // Set desired height
                child: WebView(
                  initialUrl: 'http://175.45.186.55:3000/d-solo/e43bd558-7516-4c01-acc8-caf62002788f/dashboard-data-rispro-2?orgId=1&from=now&to=now&theme=light&panelId=10',
                  javascriptMode: JavascriptMode.unrestricted,
                  backgroundColor: Colors.transparent, // Make WebView background transparent
                ),

              ),
              const SizedBox(height: 20), // Add more spacing if needed
              const Text(
                "Analythic",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5C5B5B),
                ),
              ),
              const SizedBox(height: 10), // Add spacing between text and WebView
              Container(
                width: double.infinity, // Set desired width
                height: 300, // Set desired height
                child: WebView(
                  initialUrl: 'http://175.45.186.55:3000/dashboard-solo/snapshot/JSVOeuE7F2Un0pJHnA9Tu6zpF0qKlzKq?orgId=1&from=1710901208000&to=1710910925000&theme=light&panelId=1',
                  javascriptMode: JavascriptMode.unrestricted,
                  backgroundColor: Colors.transparent, // Make WebView background transparent
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
