
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database/data_base_utils.dart';
import '../models/my_user.dart';

class UserProvider extends ChangeNotifier {
  MyUser? myUser;
  User? userAuth;

  UserProvider() {
    userAuth = FirebaseAuth.instance.currentUser;
    initMyUser();
  }

  void initMyUser() async {
    if (userAuth != null) {
      myUser = await DataBaseUtils.readUserFromFirestore(userAuth?.uid ?? "");
    }
  }
}