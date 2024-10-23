class MyUser {
  static const collectionName = "users";
  String fname;
  String lname;
  String username;
  String email;
  String uid;

  MyUser({
    required this.fname,
    required this.lname,
    required this.username,
    required this.email,
    required this.uid,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      fname: json["fname"],
      lname: json["lname"],
      username: json["username"],
      email: json["email"],
      uid: json["uid"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fname": this.fname,
      "lname": this.lname,
      "username": this.username,
      "email": this.email,
      "uid": this.uid,
    };
  }

//
}
