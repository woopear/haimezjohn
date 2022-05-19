class ProfilSchema {
  String? id;
  String title;
  String? subTitle;
  String text;
  String image;

  ProfilSchema({
    this.id,
    required this.title,
    this.subTitle,
    required this.text,
    required this.image,
  });

  factory ProfilSchema.fromMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String subTitle = data['subTitle'];
    String text = data['text'];
    String image = data['image'];

    return ProfilSchema(id: documentId, title: title, subTitle: subTitle, text: text, image: image);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle,
      'text': text,
      'image': image,
    };
  }
}
