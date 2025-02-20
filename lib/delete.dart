import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Function to delete a student
Future<void> deleteStudent(BuildContext context, String docId) async {
  try {
    await FirebaseFirestore.instance.collection('students').doc(docId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Student deleted successfully!')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to delete student: $e')),
    );
  }
}
