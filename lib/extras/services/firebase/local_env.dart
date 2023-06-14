import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future connectToFirebaseEmulator() async {
  const localHostString = "localhost";

  FirebaseFirestore.instance.settings = const Settings(
    host: "$localHostString:8080",
    sslEnabled: false,
    persistenceEnabled: false,
  );

  await FirebaseStorage.instance.useStorageEmulator(localHostString, 9199);

  // await FirebaseAuth.instance.useAuthEmulator(localHostString, 9099);
}
