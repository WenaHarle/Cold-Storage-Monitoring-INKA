import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HumidityPage extends StatefulWidget {
  @override
  _HumidityPageState createState() => _HumidityPageState();
}

class _HumidityPageState extends State<HumidityPage> {
  String selectedRange = '10 minutes'; // Default selected range
  final List<String> ranges = ['10 minutes', '1 hour', '1 day', '1 week', '1 month', '1 year'];
  List<String> analyticUrls = [];
  List<String> realTimeUrls = [];
  final List<WebViewController?> _webViewControllers = [];

  // Define your URLs in arrays
  final List<String> darkModeRealTimeUrls = [
    'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=18',
    'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=15',
    'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=20',
  ];

  final List<String> lightModeRealTimeUrls = [
    'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=18',
    'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=15',
    'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=20',
  ];

  final Map<String, List<String>> darkModeAnalyticUrls = {
    '10 minutes': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=90',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=91',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=92',
    ],
    '1 hour': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=93',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=94',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=95',
    ],
    '1 day': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=96',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=97',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=98',
    ],
    '1 week': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=99',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=101',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=102',
    ],
    '1 month': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=103',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=104',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=105',
    ],
    '1 year': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=106',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=107',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=dark&panelId=108',
    ],
  };

  final Map<String, List<String>> lightModeAnalyticUrls = {
    '10 minutes': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=90',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=91',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=92',
    ],
    '1 hour': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=93',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=94',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=95',
    ],
    '1 day': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=96',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=97',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=98',
    ],
    '1 week': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=99',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=101',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=102',
    ],
    '1 month': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=103',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=104',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=105',
    ],
    '1 year': [
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=106',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=107',
      'http://175.45.186.55:3000/d-solo/e001a7c7-1de1-4977-999c-30ec8a391284/data-sensor-detail?orgId=1&from=1721648708370&to=1721670308370&theme=light&panelId=108',
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
          'Humidity',
          style: TextStyle(
            color: Colors.white, // Set AppBar title color to white
          ),
        ),
        automaticallyImplyLeading: false, // This removes the back button
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Add padding to control spacing
            child: Icon(
              Icons.opacity,
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
