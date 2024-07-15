import 'package:flutter/material.dart';
import 'TemperaturePage.dart';
import 'pressurePage.dart';
import 'HumidityPage.dart';
import 'O2Page.dart';
import 'CO2Page.dart';
import 'CO2Infrared.dart';
import 'profilePage.dart';
import 'currentPage.dart';
import 'voltagePage.dart';

class HomePage extends StatelessWidget {
  // List of icons to be used for the buttons
  final List<IconData> icons = [
    Icons.thermostat,      // Represents Temperature
    Icons.speed,           // Represents Pressure
    Icons.opacity,         // Represents Humidity
    Icons.air,             // Represents O2
    Icons.cloud,           // Represents CO2
    Icons.light,           // Represents CO2 Infrared
    Icons.bolt,            // Represents Current
    Icons.electrical_services, // Represents Voltage
  ];

  // List of texts corresponding to each button
  final List<String> labels = [
    'Temperature',
    'Pressure',
    'Humidity',
    'O₂',
    'CO₂',
    'CO₂ Infrared',
    'Current',
    'Voltage',
  ];

  // List of corresponding actions for each button
  void _handleIconButtonPress(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TemperaturePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PressurePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HumidityPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => O2Page()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CO2Page()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CO2InfraredPage()),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CurrentPage()),
        );
        break;
      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VoltagePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color appBarColor = isDarkMode ? Colors.grey[900]! : Color(0xFF5C5B5B);
    final Color iconColor = isDarkMode ? Colors.white : Color(0xFF5C5B5B);
    final Color borderColor = isDarkMode ? Colors.white54 : Color(0xFF5C5B5B);
    final Color labelColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor, // Custom color for AppBar
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false, // Remove the back arrow
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.white,), // Icon to be displayed
            onPressed: () {
              // Action to be performed when the icon is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
        toolbarHeight: 80.0, // Set your desired height here
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 16.0, // Spacing between columns
          mainAxisSpacing: 16.0, // Spacing between rows
        ),
        itemCount: icons.length, // Number of IconButtons in the grid
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor, // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                child: IconButton(
                  icon: Icon(
                    icons[index], // Use different icons based on the index
                    size: 50,
                    color: iconColor,
                  ),
                  onPressed: () => _handleIconButtonPress(context, index),
                ),
              ),
              SizedBox(height: 8.0), // Spacing between icon and text
              Text(
                labels[index], // Text label for each button
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: labelColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
