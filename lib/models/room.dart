class Room {
  static const collectionName = "rooms";
  String id;
  String roomName;
  String roomDescription;
  String catId;

  Room({
     this.id ="",
    required this.roomName,
    required this.roomDescription,
    required this.catId,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json["id"],
      roomName: json["roomName"],
      roomDescription: json["roomDescription"],
      catId: json["catId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "roomName": this.roomName,
      "roomDescription": this.roomDescription,
      "catId": this.catId,
    };
  }

//
}
