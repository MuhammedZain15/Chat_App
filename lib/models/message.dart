class Message {
  static const String collectionName = "messages";
  String id;
  String content;
  int dataTime;
  String roomId;
  String senderId;
  String senderName;

  Message({
    this.id = "",
    required this.content,
    required this.dataTime,
    required this.roomId,
    required this.senderId,
    required this.senderName,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["id"],
      content: json["content"],
      dataTime: json["dataTime"],
      roomId: json["roomId"],
      senderId: json["senderId"],
      senderName: json["senderName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "dataTime": dataTime,
      "roomId": roomId,
      "senderId": senderId,
      "senderName": senderName,
    };
  }
}
