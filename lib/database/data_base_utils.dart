import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/my_user.dart';
import 'package:chat_app/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseUtils {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  static Future<void> addUserToFirestore(MyUser myUser) {
    return getUserCollection().doc(myUser.uid).set(myUser);
  }

  static Future<MyUser> readUserFromFirestore(String uid) async {
    var UserRef = await getUserCollection().doc(uid).get();
    return UserRef.data()!;
  }

  /*===========================================================*/
  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
          fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  static Future<void> addRoomToFirestore(Room room) {
    var docRef = getRoomCollection().doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> readRoomFromFirestore() async {
    var snapshot = await getRoomCollection().get();
    var rooms = snapshot.docs.map((doc) => doc.data()).toList();
    return rooms;
  }

/*===========================================================*/
  static CollectionReference<Message> getMessageCollection(String roomId) {
    return getRoomCollection()
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Message.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson());
  }

  static Future<void> addMessageToFirestore(Message message) {
    var docRef = getMessageCollection(message.roomId).doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> readMessageFromFirestore(
      String roomId) {
    return getMessageCollection(roomId).orderBy("dataTime").snapshots();
  }
}
