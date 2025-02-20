import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void showEditStudentDialog(
    BuildContext context, String docId, Map<String, dynamic> student) {
  TextEditingController nameController =
      TextEditingController(text: student['name']);
  TextEditingController studentIdController =
      TextEditingController(text: student['student_id']);
  TextEditingController majorController =
      TextEditingController(text: student['major']);
  TextEditingController yearController =
      TextEditingController(text: student['year']);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: studentIdController,
              decoration: InputDecoration(
                  labelText: 'Student ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: majorController,
              decoration: InputDecoration(
                  labelText: 'Major',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: yearController,
              decoration: InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              var updatedData = {
                'name': nameController.text,
                'student_id': studentIdController.text,
                'major': majorController.text,
                'year': yearController.text,
              };
              FirebaseFirestore.instance
                  .collection('students')
                  .doc(docId)
                  .update(updatedData);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
