import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  List<String> symptoms = ["Temperature", "Hormones", "Fever", "Cough", "Cold"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SmartCare"),
        actions: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("images/user.jpg"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Welcome to SmartCare",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Symptoms Prompt
              Text(
                "Do you feel sick?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: symptoms.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () =>
                          _showSymptomInformation(context, symptoms[index]),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 164, 243, 243),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            symptoms[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Health Tips
              SizedBox(height: 20),
              Text(
                "Health Tips",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 215, 197),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tip 1: Stay hydrated and drink plenty of water."),
                    Text(
                        "Tip 2: Get enough sleep for a healthy immune system."),
                    Text("Tip 3: Maintain a balanced and nutritious diet."),
                    // Add more health tip`s as needed
                  ],
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _launchEmergencyCall();
                },
                child: Text(
                  "Quick Access to Emergency Services",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSymptomInformation(BuildContext context, String symptom) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(symptom),
          content: Text("Information about $symptom goes here."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // launch emergency call
  void _launchEmergencyCall() async {
    const emergencyPhoneNumber = 'tel:***';
    if (await canLaunch(emergencyPhoneNumber)) {
      await launch(emergencyPhoneNumber);
    } else {
      print('Could not launch $emergencyPhoneNumber');
    }
  }
}
