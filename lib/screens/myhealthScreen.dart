import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHealthScreen extends StatefulWidget {
  @override
  _MyHealthScreenState createState() => _MyHealthScreenState();
}

class _MyHealthScreenState extends State<MyHealthScreen> {
  List<Map<String, dynamic>> patients = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:1331/show'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        patients = List<Map<String, dynamic>>.from(data);
      });
    } else {
      print('Failed to fetch patient data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Health'),
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: ListTile(
                title: Text('Patient Name: ${patients[index]['patient_name']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Patient ID: ${patients[index]['patient_id']}'),
                    Text('Disease: ${patients[index]['disease_name']}'),
                    Text(
                        'Test Result Date: ${patients[index]['test_result_date']}'),
                  ],
                ),
                onTap: () {
                  print('Tapped on patient ${patients[index]['patient_name']}');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyHealthScreen(),
  ));
}
