import 'package:chat_app/base.dart';
import 'package:chat_app/database/data_base_utils.dart';
import 'package:chat_app/models/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/message.dart';
import '../../models/room.dart';
import 'chat_navigator.dart';

class ChatVm extends BaseViewModel<ChatNavigator> {
  late Room room;
  late MyUser myUser;

  void sendMassage(String content) {
    Message message = Message(
      content: content,
      dataTime: DateTime.now().microsecondsSinceEpoch,
      roomId: room.id,
      senderId: myUser.uid,
      senderName: myUser.username,
    );
    DataBaseUtils.addMessageToFirestore(message).then(
      (value) {
        navigator?.clearContent();
      },
    );
  }

  Stream<QuerySnapshot<Message>> readMessage() {
    return DataBaseUtils.readMessageFromFirestore(room.id);
  }
}
