import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit.dart'; // Import edit.dart
import 'delete.dart'; // Import delete.dart

class FirestoreData extends StatelessWidget {
  const FirestoreData({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('students').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return const Text('Error fetching data');
        }
        final data = snapshot.data?.docs;
        return ListView.builder(
          itemCount: data?.length ?? 0,
          itemBuilder: (context, index) {
            final student = data?[index].data() as Map<String, dynamic>;
            final docId = data?[index].id;
            return ListTile(
              title: Text(student['name'] ?? 'No data'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Student ID: ${student['student_id'] ?? 'No data'}'),
                  Text('Major: ${student['major'] ?? 'No data'}'),
                  Text('Year: ${student['year'] ?? 'No data'}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit button
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showEditStudentDialog(context, docId!, student);
                    },
                  ),
                  // Delete button
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      deleteStudent(context, docId!);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
