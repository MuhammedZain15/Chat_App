import 'package:chat_app/base.dart';
import 'package:chat_app/database/data_base_utils.dart';
import 'package:chat_app/models/my_user.dart';
import 'package:chat_app/modules/create_account/connector.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccountVm extends BaseViewModel<CreateAccountNavigator> {
  void createAccount(String username, String fname, String lname,
      String emailAddress, String password) async {
    try {
      navigator!.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      MyUser myUser = MyUser(
        fname: fname,
        lname: lname,
        username: username,
        email: emailAddress,
        uid: credential.user!.uid,
      );
      DataBaseUtils.addUserToFirestore(myUser);
      navigator?.goToHome(myUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator!.hideLoading();
        navigator!.showMessage("The password provided is too weak.");

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator!.hideLoading();
        navigator!.showMessage("The account already exists for that email.");
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
