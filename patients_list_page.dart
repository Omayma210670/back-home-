// ...existing code...
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'patient_profile_page.dart';

class PatientsListPage extends StatelessWidget {
  const PatientsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patients"),
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        // Read the current user's patients subcollection
        stream: (() {
          final user = FirebaseAuth.instance.currentUser;
          if (user == null) return Stream<QuerySnapshot<Map<String, dynamic>>>.empty();
          return FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('patients')
              .orderBy('createdAt', descending: true)
              .snapshots();
        })(),

        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Patients Yet",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final patients = snapshot.data!.docs;

          return ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final doc = patients[index];
              final patient = doc.data(); // Map<String, dynamic>

              final name = patient['name'] ?? 'No Name';
              final age = patient['age'] ?? '--';
              final condition = patient['medicalCondition'] ?? '--';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("$age Years • $condition"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PatientProfilePage(
                          patientId: doc.id,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_new_patient');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
// ...existing code...