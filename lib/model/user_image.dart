class UserImage {
  int userId;
  int id;
  String title;
  String imagePath;
  String thumbnailPath;

  // UserImage(
  //     {required this.userId,
  //     required this.id,
  //     required this.title,
  //     required this.imagePath,
  //     required this.thumbnailPath});

  // factory UserImage.fromJson(Map<String, dynamic> json) {
  //   return UserImage(
  //       userId: json['albumId'],
  //       id: json['id'],
  //       title: json['title'],
  //       imagePath: json['url'],
  //       thumbnailPath: json['thumbnailUrl']);
  // }

  UserImage.fromJson(Map json)
      : userId = json['albumId'],
        id = json['id'],
        title = json['title'],
        imagePath = json['url'],
        thumbnailPath = json['thumbnailUrl'];

  Map toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'imagePath': imagePath,
      'thumbnailPath': thumbnailPath
    };
  }
}
