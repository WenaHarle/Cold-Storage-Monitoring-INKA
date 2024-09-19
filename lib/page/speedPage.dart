import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpeedPage extends StatefulWidget {
  @override
  _SpeedPageState createState() => _SpeedPageState();
}

class _SpeedPageState extends State<SpeedPage> {
  final List<String> ranges = [
    'Last 1 Minute',
    'Last 5 Minutes',
    'Last 10 Minutes',
    'Last 1 Hour',
    'Last 24 Hours',
    'Last 7 Days',
    'Last 1 Month',
    'Last 1 Year'
  ];
  String selectedRange = 'Last 1 Minute';

  List<String> realTimeUrls = [];
  List<String> analyticUrls = [];

  @override
  void initState() {
    super.initState();
    // Initialize URLs based on the initial theme and range
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    realTimeUrls = generateRealTimeUrls(brightness);
    analyticUrls = generateAnalyticUrls(selectedRange, brightness);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update the URLs if the theme changes
    realTimeUrls = generateRealTimeUrls(Theme.of(context).brightness);
    analyticUrls = generateAnalyticUrls(selectedRange, Theme.of(context).brightness);
  }

  // Generate Real-Time URLs based on the theme
  List<String> generateRealTimeUrls(Brightness brightness) {
    final theme = brightness == Brightness.dark ? 'dark' : 'light';

    return [
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=now&to=now&theme=$theme&panelId=36',
    ];
  }

  // Generate Analytic URLs based on the theme and selected time range
  List<String> generateAnalyticUrls(String range, Brightness brightness) {
    final theme = brightness == Brightness.dark ? 'dark' : 'light';
    final now = DateTime.now().millisecondsSinceEpoch;
    final rangeMap = {
      'Last 1 Minute': now - 60000,
      'Last 5 Minutes': now - 300000,
      'Last 10 Minutes': now - 600000,
      'Last 1 Hour': now - 3600000,
      'Last 24 Hours': now - 86400000,
      'Last 7 Days': now - 604800000,
      'Last 1 Month': now - 2592000000,
      'Last 1 Year': now - 31536000000,
    };

    final from = rangeMap[range] ?? now - 3600000;

    return [
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=$from&to=$now&theme=$theme&panelId=80',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C5B5B),
        title: const Text(
          'Speed Motor',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.speed,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Real Time",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5C5B5B),
                ),
              ),
              const SizedBox(height: 10),
              // Display real-time data in WebView widgets
              ...realTimeUrls.map((url) => Container(
                width: double.infinity,
                height: 300,
                margin: const EdgeInsets.only(bottom: 10),
                child: WebView(
                  key: ValueKey(url),
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  backgroundColor: Colors.transparent,
                ),
              )).toList(),
              const SizedBox(height: 20),
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
                  const SizedBox(width: 10),
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
                        // Update URLs when the selected range changes
                        analyticUrls = generateAnalyticUrls(selectedRange, Theme.of(context).brightness);
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Display analytic data in WebView widgets
              ...analyticUrls.map((url) => Container(
                width: double.infinity,
                height: 300,
                margin: const EdgeInsets.only(bottom: 10),
                child: WebView(
                  key: ValueKey(url),
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  backgroundColor: Colors.transparent,
                ),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
