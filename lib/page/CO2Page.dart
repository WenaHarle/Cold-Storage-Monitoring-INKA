import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CO2Page extends StatefulWidget {
  @override
  _CO2PageState createState() => _CO2PageState();
}

class _CO2PageState extends State<CO2Page> {
  String selectedRange = '10 minutes'; // Default selected range
  final List<String> ranges = ['10 minutes', '1 hour', '1 day', '1 week', '1 month', '1 year'];
  List<String> analyticUrls = [];
  List<String> realTimeUrls = [];
  final List<WebViewController?> _webViewControllers = [];

  // Define your URLs in arrays
  final List<String> darkModeRealTimeUrls = [
    'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721765056727&to=1721786656727&theme=dark&panelId=25',
    'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=30',
    'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=63',
    'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=64'
  ];

  final List<String> lightModeRealTimeUrls = [
    'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=20',
    'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=30',
    'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=63',
    'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=64'
  ];

  final Map<String, List<String>> darkModeAnalyticUrls = {
    '10 minutes': [
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=5',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=8',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=53',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=54'

    ],
    '1 hour': [
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=5',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=8',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=53',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=54'
    ],
    '1 day': [
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=5',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=8',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=53',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=54'
    ],
    '1 week': [
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=5',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=8',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=53',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=54'
    ],
    '1 month': [
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=5',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=8',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=53',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=54'
    ],
    '1 year': [
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=5',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=8',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=53',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=54'
    ],
  };

  final Map<String, List<String>> lightModeAnalyticUrls = {
    '10 minutes': [
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=5',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=8',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=53',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=54'

    ],
    '1 hour': [
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=5',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=8',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=53',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=54'
    ],
    '1 day': [
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=5',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=8',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=53',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=54'
    ],
    '1 week': [
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=5',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=8',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=53',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=54'
    ],
    '1 month': [
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=5',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=8',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=53',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=54'
    ],
    '1 year': [
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=5',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=8',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=53',
      'https://rarief.com:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=54'
    ],
  };


  @override
  void initState() {
    super.initState();
    // Perform initialization that doesn't rely on context or theme
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update URLs based on the theme
    _updateUrlsAndReload();
  }

  void _updateUrlsAndReload() {
    final brightness = Theme.of(context).brightness;
    realTimeUrls = brightness == Brightness.dark ? darkModeRealTimeUrls : lightModeRealTimeUrls;
    analyticUrls = generateAnalyticUrls(selectedRange, brightness);
    // Reload WebViews after updating URLs
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reloadWebViews();
    });
  }

  List<String> generateAnalyticUrls(String range, Brightness brightness) {
    final baseUrls = brightness == Brightness.dark ? darkModeAnalyticUrls : lightModeAnalyticUrls;
    return baseUrls[range] ?? [];
  }

  void _reloadWebViews() {
    for (int i = 0; i < _webViewControllers.length; i++) {
      if (realTimeUrls.length > i) {
        _webViewControllers[i]?.loadUrl(realTimeUrls[i]);
      }
    }
  }

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Add padding to control spacing
            child: Icon(
              Icons.cloud,
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
              ...realTimeUrls.asMap().entries.map((entry) {
                final index = entry.key;
                final url = entry.value;
                return Container(
                  height: 200,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: WebView(
                    initialUrl: url,
                    javascriptMode: JavascriptMode.unrestricted,
                    backgroundColor: Colors.transparent,
                    onWebViewCreated: (WebViewController webViewController) {
                      if (index >= _webViewControllers.length) {
                        _webViewControllers.add(webViewController);
                      } else {
                        _webViewControllers[index] = webViewController;
                      }
                    },
                  ),
                );
              }).toList(),
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
              ...analyticUrls.map((url) => Container(
                width: double.infinity,
                height: 300,
                margin: const EdgeInsets.only(bottom: 10),
                child: WebView(
                  key: ValueKey(url),
                  initialUrl: url,
                  javascriptMode: JavascriptMode.unrestricted,
                  backgroundColor: Colors.transparent,
                  onWebViewCreated: (WebViewController webViewController) {
                    // You might need to manage these controllers if you have multiple analytics views
                  },
                ),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
