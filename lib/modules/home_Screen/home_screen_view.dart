import 'package:chat_app/base.dart';
import 'package:chat_app/modules/add_room/add_room_view.dart';
import 'package:chat_app/modules/home_Screen/home_screen_vm.dart';
import 'package:chat_app/modules/home_Screen/room_widget.dart';
import 'package:chat_app/modules/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen_navigator.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends BaseView<HomeScreenView, HomeScreenVm>
    implements HomeScreenNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    viewModel.getRooms();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.getRooms();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
          color: Colors.white,
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoomView.routeName);
              },
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                )
              ],
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Chat App",
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16, right: 16),
              child: Consumer<HomeScreenVm>(builder: (_, model, child) {
                model.getRooms();
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return RoomWidget(room: model.rooms[index]);
                  },
                  itemCount: model.rooms.length,
                );
              }),
            )),
      ),
    );
  }

  @override
  HomeScreenVm initViewModel() {
    return HomeScreenVm();
  }
}
