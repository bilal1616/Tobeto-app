// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tobeto_app/model/profile.dart';

// class ProfileViewModel with ChangeNotifier {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   FirebaseStorage _storage = FirebaseStorage.instance;

//   String? _url;
//   String? get imageUrl => _url;

//   // User? user;  
//   // ProfileViewModel() {
//   //   user = _auth.currentUser;
//   //   if (user != null) {
//   //     userid = user!.uid;
//   //   }
//   // }

//   void addProfileInfo(
//     BuildContext context,
//     String name,
//     String surname,
//     String tc,
//     String email,
//     String country,
//     String district,
//     String phone,
//     String birthDate,
//   ) async {
//     if (_url != null) {
//       Profile profile = Profile(
//         // userid!,
//         name,
//         surname,
//         tc,
//         _url!,
//         email,
//         country,
//         district,
//         phone,
//         birthDate,
//       );

//       try {
//         await _firestore.collection("profile_info").add(profile.toMap());
//         Navigator.pop(context);
//       } catch (e) {
//         print("Error adding profile information: $e");
//       }
//     }
//   }

//   Future<void> pickImage(String name) async {
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);

//       if (image == null) return;

//       final imageTemp = File(image.path);

//       TaskSnapshot snapshot =
//           await _storage.ref("users/$name.jpg").putFile(imageTemp);
//       _url = await snapshot.ref.getDownloadURL();

//       notifyListeners();
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }
// }
