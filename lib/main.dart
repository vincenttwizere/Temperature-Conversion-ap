import 'package:flutter/material.dart';

void main() => runApp(TempConverterApp());

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.teal[900],
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            color: Colors.teal[800],
          ),
        ),
      ),
      home: TempConverterScreen(),
    );
  }
}

class TempConverterScreen extends StatefulWidget {
  @override
  _TempConverterScreenState createState() => _TempConverterScreenState();
}

class _TempConverterScreenState extends State<TempConverterScreen> {
  String _conversionType = 'F to C';
  TextEditingController _controller = TextEditingController();
  String _convertedValue = '';
  List<String> _history = [];

  void _convertTemperature() {
    double input = double.tryParse(_controller.text) ?? 0;
    double converted;
    if (_conversionType == 'F to C') {
      converted = (input - 32) * 5 / 9;
    } else {
      converted = (input * 9 / 5) + 32;
    }
    setState(() {
      _convertedValue = converted.toStringAsFixed(1);
      _history.insert(0, '$_conversionType: $input => $_convertedValue');
    });
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Match the convert button color
        title: const Text(
          'Temperature Converter',
          style: TextStyle(
            color: Colors.white, // Set title text color to white
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Select Conversion Type',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[700]),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Fahrenheit to Celsius'),
                                value: 'F to C',
                                groupValue: _conversionType,
                                onChanged: (value) {
                                  setState(() {
                                    _conversionType = value!;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: const Text('Celsius to Fahrenheit'),
                                value: 'C to F',
                                groupValue: _conversionType,
                                onChanged: (value) {
                                  setState(() {
                                    _conversionType = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter Temperature',
                      labelStyle: TextStyle(color: Colors.teal[700]),
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal[900]!),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _convertTemperature,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      'Convert',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Converted Value: $_convertedValue',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[900]),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _clearHistory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[600],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      'Delete History',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: orientation == Orientation.portrait ? 300 : 150,
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Conversion History',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal[700]),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _history.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    _history[index],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
