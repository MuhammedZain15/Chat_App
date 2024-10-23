import 'package:chat_app/base.dart';
import 'package:chat_app/database/data_base_utils.dart';
import 'package:chat_app/models/room.dart';

import 'add_room_navigator.dart';

class AddRoomVm extends BaseViewModel<AddRoomNavigator> {
  void addRoom(String roomName, String roomDescription, String catId) async {
    Room room = Room(
      roomName: roomName,
      roomDescription: roomDescription,
      catId: catId,
    );
    DataBaseUtils.addRoomToFirestore(room).then((value) {
      navigator!.roomAdded();
    }).catchError((error) {
      navigator!.showMessage(error.toString());
    });
  }
}
