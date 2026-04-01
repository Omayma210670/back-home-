import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/app_colors.dart';
import '../core/page_shell.dart';
import '../core/widgets.dart';

class PatientProfilePage extends StatelessWidget {
  const PatientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('patients')
            .snapshots(),
        builder: (context, snapshot) {
            print("STREAM IS RUNNING");

         if (snapshot.hasData) {
         print(snapshot.data!.docs.map((e) => e['name']).toList());
        }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No patient found"));
          }

          // ✅ هذا السطر الجديد للتأكد
          print(snapshot.data!.docs.map((e) => e['name']).toList());

          final docs = snapshot.data!.docs;
          final data = docs.last.data() as Map<String, dynamic>;

          return PageShell(
            title: "TEST PAGE 123",
            child: Column(
              children: [

                const SizedBox(height: 20),

                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade200,
                  child: const Icon(Icons.person, size: 50),
                ),

                const SizedBox(height: 12),

               Text(
               "AAAAA",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: infoCard(
                        title: "Age",
                        value: "${data['age'] ?? ''} Years",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: infoCard(
                        title: "Condition",
                        value: data['medicalCondition'] ?? '',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: infoCard(
                        title: "Blood Type",
                        value: data['bloodType'] ?? 'N/A',
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: infoCard(
                        title: "Watch Status",
                        value: "Connected ✓",
                        valueColor: Colors.green,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}