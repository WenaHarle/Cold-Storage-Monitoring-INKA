import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PowerPage extends StatefulWidget {
  @override
  _PowerPageState createState() => _PowerPageState();
}

class _PowerPageState extends State<PowerPage> {
  String selectedRange = '10 minutes'; // Default selected range
  final List<String> ranges = ['10 minutes', '1 hour', '1 day', '1 month', '1 year'];
  List<String> analyticUrls = [];

  @override
  void initState() {
    super.initState();
    analyticUrls = generateUrls(selectedRange);
  }

  List<String> generateUrls(String range) {
    // Generate URLs based on the selected range
    // You might need to adjust the logic to fit your specific URL structure and parameters
    switch (range) {
      case '10 minutes':
        return [
          'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&panelId=44',
          'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&panelId=41',
          'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&panelId=42',
          'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&panelId=43'

        ];
      case '1 hour':
        return [
          'http://example.com/1h_1',
          'http://example.com/1h_2',
          'http://example.com/1h_3'
        ];
      case '1 day':
        return [
          'http://example.com/1d_1',
          'http://example.com/1d_2',
          'http://example.com/1d_3'
        ];
      case '1 month':
        return [
          'http://example.com/1M_1',
          'http://example.com/1M_2',
          'http://example.com/1M_3'
        ];
      case '1 year':
        return [
          'http://example.com/1y_1',
          'http://example.com/1y_2',
          'http://example.com/1y_3'
        ];
      default:
        return [
          'http://example.com/default_1',
          'http://example.com/default_2',
          'http://example.com/default_3'
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5C5B5B), // Keep AppBar background color
        title: Text(
          'Power',
          style: TextStyle(
            color: Colors.white, // Set AppBar title color to white
          ),
        ),
        automaticallyImplyLeading: false, // This removes the back button
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Add padding to control spacing
            child: Icon(
              Icons.light,
              color: Colors.white,
            ),
          ),
        ],
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
              const SizedBox(height: 10), // Add spacing between text and WebView
              Container(
                height: 200, // Set desired height
                child: WebView(
                  initialUrl: 'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&panelId=48', // Example URL for additional WebView
                  javascriptMode: JavascriptMode.unrestricted,
                  backgroundColor: Colors.transparent, // Make WebView background transparent
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 200, // Set desired height
                      child: WebView(
                        initialUrl: 'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&panelId=45',
                        javascriptMode: JavascriptMode.unrestricted,
                        backgroundColor: Colors.transparent, // Make WebView background transparent
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 200, // Set desired height
                      child: WebView(
                        initialUrl: 'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&panelId=46',
                        javascriptMode: JavascriptMode.unrestricted,
                        backgroundColor: Colors.transparent, // Make WebView background transparent
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Add spacing between WebViews
                  Expanded(
                    child: Container(
                      height: 200, // Set desired height
                      child: WebView(
                        initialUrl: 'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&panelId=47', // Example URL for additional WebView
                        javascriptMode: JavascriptMode.unrestricted,
                        backgroundColor: Colors.transparent, // Make WebView background transparent
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Add more spacing if needed

              Row(
                children: [
                  const Text(
                    "Analytic",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5C5B5B),
                    ),
                  ),
                  const SizedBox(width: 10), // Spacing between text and dropdown
                  DropdownButton<String>(
                    value: selectedRange,
                    items: ranges.map((String range) {
                      return DropdownMenuItem<String>(
                        value: range,
                        child: Text(range),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRange = newValue!;
                        analyticUrls = generateUrls(selectedRange); // Update the URLs
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10), // Add spacing between text and WebView

              // Additional WebView for Analytic
              ...analyticUrls.map((url) => Container(
                width: double.infinity, // Set desired width
                height: 300, // Set desired height
                margin: const EdgeInsets.only(bottom: 10), // Add margin between WebViews
                child: WebView(
                  key: ValueKey(url), // Add key to force rebuild
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  backgroundColor: Colors.transparent, // Make WebView background transparent
                ),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
