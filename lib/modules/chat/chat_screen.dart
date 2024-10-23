import 'package:chat_app/base.dart';
import 'package:chat_app/modules/chat/chat_vm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/message.dart';
import '../../models/room.dart';
import '../../provider/user_provider.dart';
import '../add_room/message_widget.dart';
import 'chat_navigator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String routeName = "ChatScreen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseView<ChatScreen, ChatVm>
    implements ChatNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  var massegeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as Room;
    var provider = Provider.of<UserProvider>(context);
    viewModel.room = room;
    viewModel.myUser = provider.myUser!;
    viewModel.readMessage();
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
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                room.roomName,
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 62,
              horizontal: 18,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: viewModel.readMessage(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Text("Something went wrong");
                      }
                      var messages =
                          snapshot.data!.docs.map((e) => e.data()).toList();
                      return ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          var message = messages[index];
                          return MessageWidget(message: message);
                        },
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: massegeController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                            ),
                          ),
                          hintText: "Type a Message",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          viewModel.sendMassage(
                            massegeController.text,
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              "send",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 25,
                            )
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ChatVm initViewModel() {
    return ChatVm();
  }

  @override
  void clearContent() {
    massegeController.clear();
    setState(() {});
  }
}
