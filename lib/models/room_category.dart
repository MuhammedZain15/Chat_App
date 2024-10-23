class RoomCategory {
  static String sportId = "sports";
  static String moviesId = "movies";
  static String musicId = "music";
  String id;
  late String name;
  late String image;

  RoomCategory(this.id, this.name, this.image);

  RoomCategory.fromId(this.id) {
    name = id;
    image = "assets/images/$id.png";
  }

  static List<RoomCategory> getRoomCategories() {
    return [
      RoomCategory.fromId(sportId),
      RoomCategory.fromId(moviesId),
      RoomCategory.fromId(musicId),
    ];
  }
}
