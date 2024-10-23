import 'package:chat_app/base.dart';
import 'package:chat_app/database/data_base_utils.dart';
import 'package:chat_app/models/room.dart';

import 'home_screen_navigator.dart';

class HomeScreenVm extends BaseViewModel<HomeScreenNavigator> {
  List<Room> rooms = [];

  void getRooms() async {
    rooms = await DataBaseUtils.readRoomFromFirestore();
    print(rooms.length);
  }
}
