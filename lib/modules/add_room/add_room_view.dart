import 'package:chat_app/base.dart';
import 'package:chat_app/models/room_category.dart';
import 'package:chat_app/modules/add_room/add_room_vm.dart';
import 'package:chat_app/modules/home_Screen/home_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_room_navigator.dart';

class AddRoomView extends StatefulWidget {
  const AddRoomView({super.key});

  static const String routeName = 'AddRoomView';

  @override
  State<AddRoomView> createState() => _AddRoomViewState();
}

class _AddRoomViewState extends BaseView<AddRoomView, AddRoomVm>
    implements AddRoomNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    roomCategory = category[0];
  }

  var category = RoomCategory.getRoomCategories();

  var formkey = GlobalKey<FormState>();
  var roomNameController = TextEditingController();
  var roomDescriptionController = TextEditingController();
  late RoomCategory roomCategory;

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                "Add Room",
              ),
            ),
          ),
          body: Card(
            color: Colors.white,
            elevation: 16,
            margin: const EdgeInsets.symmetric(horizontal: 21, vertical: 42),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      textAlign: TextAlign.center,
                      "Create New Room",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Image.asset("assets/images/room.png"),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please Enter Room Name";
                        }
                        return null;
                      },
                      controller: roomNameController,
                      cursorHeight: 30,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.text_snippet,
                        ),
                        errorStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        hintText: "Room Name",
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DropdownButton<RoomCategory>(
                      padding: const EdgeInsets.all(5),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      hint: const Text("Choose Room Category"),
                      value: roomCategory,
                      items: category
                          .map(
                            (e) => DropdownMenuItem<RoomCategory>(
                              value: e,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(e.image),
                                  Text(e.name),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        roomCategory = value;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please Enter Room Description";
                        }
                        return null;
                      },
                      controller: roomDescriptionController,
                      cursorHeight: 30,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.description,
                        ),
                        errorStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        hintText: "Room Description",
                      ),
                    ),
                    const SizedBox(
                      height: 30,
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
                          viewModel.addRoom(
                            roomNameController.text,
                            roomDescriptionController.text,
                            roomCategory.id,
                          );
                          Navigator.pushReplacementNamed(
                              context, HomeScreenView.routeName);
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Create Room",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.add,
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
    );
  }

  @override
  AddRoomVm initViewModel() {
    return AddRoomVm();
  }

  @override
  void roomAdded() {
    Navigator.pushReplacementNamed(context, HomeScreenView.routeName);
  }
}
