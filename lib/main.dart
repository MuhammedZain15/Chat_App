import 'package:chat_app/modules/create_account/create_account.dart';
import 'package:chat_app/modules/home_Screen/home_screen_view.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/shared/style/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'modules/add_room/add_room_view.dart';
import 'modules/chat/chat_screen.dart';
import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return MaterialApp(
        theme: MyThemeData.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: provider.userAuth == null
            ? LoginScreen.routeName
            : HomeScreenView.routeName,
        routes: {
          CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          HomeScreenView.routeName: (context) => const HomeScreenView(),
          AddRoomView.routeName: (context) => const AddRoomView(),
          ChatScreen.routeName: (context) => const ChatScreen(),
        });
  }
}
