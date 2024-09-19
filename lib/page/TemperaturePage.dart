import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TemperaturePage extends StatefulWidget {
  @override
  _TemperaturePageState createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize the URLs based on the current theme and range
    realTimeUrls = generateRealTimeUrls(Theme.of(context).brightness);
    analyticUrls = generateAnalyticUrls(selectedRange, Theme.of(context).brightness);
  }

  // Generate Real-Time URLs based on the theme
  List<String> generateRealTimeUrls(Brightness brightness) {
    final theme = brightness == Brightness.dark ? 'dark' : 'light';

    return [
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=1726644172786&to=1726644472786&theme=$theme&panelId=1',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=1726644172786&to=1726644472786&theme=$theme&panelId=4',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=1726644172786&to=1726644472786&theme=$theme&panelId=6',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=1726644172786&to=1726644472786&theme=$theme&panelId=8',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=1726644172786&to=1726644472786&theme=$theme&panelId=12',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=1726644172786&to=1726644472786&theme=$theme&panelId=14',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=1726644172786&to=1726644472786&theme=$theme&panelId=16',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=1726644172786&to=1726644472786&theme=$theme&panelId=18',
    ];
  }

  // Generate Analytic URLs based on the theme and selected time range
  List<String> generateAnalyticUrls(String range, Brightness brightness) {
    final theme = brightness == Brightness.dark ? 'dark' : 'light';
    final now = DateTime.now().millisecondsSinceEpoch;
    final rangeMap = {
      'Last 1 Minute': now - 60000, // 1 minute = 60,000 milliseconds
      'Last 5 Minutes': now - 300000, // 5 minutes = 300,000 milliseconds
      'Last 10 Minutes': now - 600000, // 10 minutes = 600,000 milliseconds
      'Last 1 Hour': now - 3600000, // 1 hour = 3,600,000 milliseconds
      'Last 24 Hours': now - 86400000, // 24 hours = 86,400,000 milliseconds
      'Last 7 Days': now - 604800000, // 7 days = 604,800,000 milliseconds
      'Last 1 Month': now - 2592000000, // 1 month ≈ 2,592,000,000 milliseconds
      'Last 1 Year': now - 31536000000, // 1 year ≈ 31,536,000,000 milliseconds
    };

    final from = rangeMap[range] ?? now - 3600000;

    return [
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=$from&to=$now&theme=$theme&panelId=42',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=$from&to=$now&theme=$theme&panelId=43',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=$from&to=$now&theme=$theme&panelId=44',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=$from&to=$now&theme=$theme&panelId=45',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=$from&to=$now&theme=$theme&panelId=47',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=$from&to=$now&theme=$theme&panelId=48',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=$from&to=$now&theme=$theme&panelId=49',
      'https://rarief.com:3000/d-solo/f77661b1-54aa-4ae1-b3d6-fe60e777effe/data-erispro?orgId=1&from=$from&to=$now&theme=$theme&panelId=50',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C5B5B), // Keep AppBar background color
        title: const Text(
          'Temperature',
          style: TextStyle(
            color: Colors.white, // Set AppBar title color to white
          ),
        ),
        automaticallyImplyLeading: false, // This removes the back button
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0), // Add padding to control spacing
            child: Icon(
              Icons.thermostat,
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
              // Use GridView to display real-time data in two rows
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two columns
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5, // Adjust for proper height/width ratio
                ),
                itemCount: realTimeUrls.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    child: WebView(
                      initialUrl: realTimeUrls[index],
                      javascriptMode: JavascriptMode.unrestricted,
                      backgroundColor: Colors.transparent,
                    ),
                  );
                },
              ),
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
                ),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
