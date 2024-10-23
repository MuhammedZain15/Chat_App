import 'package:chat_app/base.dart';
import 'package:chat_app/models/my_user.dart';
import 'package:chat_app/modules/create_account/connector.dart';
import 'package:chat_app/modules/create_account/create_account_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../home_Screen/home_screen_view.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String routeName = 'CreateAccount';

  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState
    extends BaseView<CreateAccountScreen, CreateAccountVm>
    implements CreateAccountNavigator {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
          color: Colors.white,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: const Text(
              "Create Account",
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formkey,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 230,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,

                        controller: fnameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter First Name";
                          }
                          return null;
                        },
                        /*controller: fullnameController,*/

                        cursorHeight: 30,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 2,
                              )),
                          hintText: "First Name",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: lnameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Last Name";
                          }
                          return null;
                        },
                        /*controller: fullnameController,*/

                        cursorHeight: 30,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 2,
                              )),
                          hintText: "Last Name",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: fullnameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter User Name";
                          }
                          return null;
                        },
                        /*controller: fullnameController,*/

                        cursorHeight: 30,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.person,
                          ),
                          errorStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 2,
                              )),
                          hintText: "Full Name",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Your Email";
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return "Please Enter A Valid Email";
                          }
                          return null;
                        },
                        controller: emailController,
                        cursorHeight: 30,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.email_outlined,
                          ),
                          errorStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 2,
                              )),
                          hintText: "Email",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Your Password";
                          }
                          return null;
                        },
                        controller: passwordController,
                        cursorHeight: 30,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.remove_red_eye,
                          ),
                          errorStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 2,
                            ),
                          ),
                          hintText: "Password",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            viewModel.createAccount(
                              fullnameController.text,
                              fnameController.text,
                              lnameController.text,
                              emailController.text,
                              passwordController.text,
                            );
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Create Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  CreateAccountVm initViewModel() {
    return CreateAccountVm();
  }

  @override
  void goToHome(MyUser user) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    provider.myUser = user;
    Navigator.pushReplacementNamed(context, HomeScreenView.routeName);
  }
}
