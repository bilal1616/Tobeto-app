import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CertificateTab extends StatefulWidget {
  @override
  _CertificateTabState createState() => _CertificateTabState();
}
class _CertificateTabState extends State<CertificateTab> {
  
  File? _selectedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sertifikalarım',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
            onPressed: _pickFile,
            child: Text("Dosya Seç",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
          SizedBox(height: 20),
          _selectedFile != null
              ? Text("Seçilen Dosya: ${_selectedFile!.path}")
              : Text("Henüz dosya seçilmedi."),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                onPressed: () {
                  _saveCertificatesToFirestore();
                },
                child: Text(
                  "Kaydet",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

 

void _saveCertificatesToFirestore() async {  
final String? userId = FirebaseAuth.instance.currentUser?.uid;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference<Map<String, dynamic>> certificatesCollection =
      firestore.collection('certificates');
      
  await certificatesCollection.doc(userId).set({
  });

  if (_selectedFile != null) {
    String fileName = 'certificates/${userId}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);

    await storageReference.putFile(_selectedFile!);
    String downloadURL = await storageReference.getDownloadURL();
    await certificatesCollection.doc(userId).update({
      'certificateURL': downloadURL,
    });
  }
}

 


 


}
