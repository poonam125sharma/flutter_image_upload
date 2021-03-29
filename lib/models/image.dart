class Image {
  int id;
  String imageName;

  Image({
    this.id,
    this.imageName
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageName': imageName
    };
  }

  Image.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    imageName = map['imageName'];
  }
}