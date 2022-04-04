class Character {
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String status;
  late List<dynamic> appearance;
  late String actorName;
  late String category;

  Character.fromJson(Map<String, dynamic> characterJson) {
    charId = characterJson['char_id'];
    name = characterJson['name'];
    nickName = characterJson['nickname'];
    image = characterJson['img'];
    jobs = characterJson['occupation'];
    status = characterJson['status'];
    appearance = characterJson['appearance'];
    actorName = characterJson['portrayed'];
    category = characterJson['category'];
  }
}
