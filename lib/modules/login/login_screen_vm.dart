import 'package:chat_app/database/data_base_utils.dart';
import 'package:chat_app/models/my_user.dart';
import 'package:chat_app/modules/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../base.dart';

class LoginScreenVm extends BaseViewModel<LoginNavigator> {
  void login(String email, String password) async {
    try {
      navigator?.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser myUser =
          await DataBaseUtils.readUserFromFirestore(credential.user!.uid);
      navigator?.hideLoading();
      navigator?.goToHome(myUser);
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        navigator?.hideLoading();
        navigator?.showMessage("No user found for that email");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator?.hideLoading();
        navigator?.showMessage("Wrong password provided for that user");
        print('Wrong password provided for that user.');
      }
    }
  }
}
