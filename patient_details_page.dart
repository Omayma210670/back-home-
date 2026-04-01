import 'package:flutter/material.dart';

class PatientDetailsPage extends StatelessWidget {
  final Map<String, dynamic> patientData;

  const PatientDetailsPage({
    super.key,
    required this.patientData,
  });

  @override
  Widget build(BuildContext context) {

    final name = patientData['name'] ?? 'No Name';
    final age = patientData['age'] ?? '--';
    final condition = patientData['medicalCondition'] ?? '--';
    final bloodType = patientData['bloodType'] ?? '--';
    final notes = patientData['notes'] ?? 'No Notes';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Profile"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 45,
              child: Icon(Icons.person, size: 40),
            ),

            const SizedBox(height: 15),

            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: _infoCard("Age", "$age Years"),
                ),

                Expanded(
                  child: _infoCard("Condition", condition),
                ),
              ],
            ),

            Row(
              children: [

                Expanded(
                  child: _infoCard("Blood Type", bloodType),
                ),

                Expanded(
                  child: _infoCard("Watch Status", "Connected ✓"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Notes:",
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(notes),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Edit Profile"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
