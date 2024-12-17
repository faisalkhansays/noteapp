import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/ui/HomeScreen.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController noteController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: noteController
                ..text = Get.arguments['note'].toString(),
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('notes')
                      .doc(Get.arguments['docId'].toString())
                      .update({
                    'note': noteController.text.trim(),
                  }).then((value) => {
                            Get.offAll(() => const HomeScreen()),
                            log('Data updated'),
                          });
                },
                child: const Text("Update"))
          ],
        ),
      ),
    );
  }
}
