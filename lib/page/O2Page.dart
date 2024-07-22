import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class O2Page extends StatefulWidget {
  @override
  _O2PageState createState() => _O2PageState();
}

class _O2PageState extends State<O2Page> {
  String selectedRange = '10 minutes'; // Default selected range
  final List<String> ranges = ['10 minutes', '1 hour', '1 day', '1 week', '1 month', '1 year'];
  List<String> analyticUrls = [];
  List<String> realTimeUrls = [];
  final List<WebViewController?> _webViewControllers = [];

  // Define your URLs in arrays
  final List<String> darkModeRealTimeUrls = [
    'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=29',
    'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=65',
    'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=66'
  ];

  final List<String> lightModeRealTimeUrls = [
    'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=29',
    'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=65',
    'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=66'
  ];

  final Map<String, List<String>> darkModeAnalyticUrls = {
    '10 minutes': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=6',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=55',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=56'
    ],
    '1 hour': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=6',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=55',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=56'
    ],
    '1 day': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=6',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=55',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=56'
    ],
    '1 week': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=6',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=55',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=56'
    ],
    '1 month': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=6',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=55',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=56'
    ],
    '1 year': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=6',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=55',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=dark&panelId=56'
    ],
  };

  final Map<String, List<String>> lightModeAnalyticUrls = {
    '10 minutes': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=6',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=55',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=56'
    ],
    '1 hour': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=6',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=55',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=56'
    ],
    '1 day': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=6',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=55',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=56'
    ],
    '1 week': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=6',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=55',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=56'
    ],
    '1 month': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=6',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=55',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=56'
    ],
    '1 year': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=6',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=55',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1720878240768&to=1721569440768&theme=light&panelId=56'
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
          'O₂',
          style: TextStyle(
            color: Colors.white, // Set AppBar title color to white
          ),
        ),
        automaticallyImplyLeading: false, // This removes the back button
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Add padding to control spacing
            child: Icon(
              Icons.air,
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
