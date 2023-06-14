import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FireStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(
      {required String ownerId, required String imagePath}) async {
    var uuid = const Uuid().v1();
    Reference reference = _storage.ref().child("posts/$ownerId/post_$uuid.jpg");
    UploadTask uploadTask = reference.putFile(File(imagePath));

    String downloadUrl = await (await uploadTask).ref.getDownloadURL();

    return downloadUrl;
  }
}
