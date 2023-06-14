import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shamba_huru/extras/services/firebase/database.dart';

import '../../utils/constant.dart';

class FireNotification {
  static final FireNotification _singleton = FireNotification._internal();

  factory FireNotification() {
    return _singleton;
  }

  FireNotification._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FireDatabase _database = FireDatabase();

  Future<void> setUpNotification() async {
    if (Platform.isAndroid) {
      _firebaseMessaging.getToken().then((token) {
        print("Firebase Messaging Token: " + token!);

        if (auth.currentUser != null) {
          _database.storeNotificationToken(
              userId: auth.currentUser!.uid, token: token);
        }
      });
    }
  }
}
