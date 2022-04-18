class TechnoSchema {
  String? id;
  String title;
  String text;
  String image;

  TechnoSchema({
    this.id,
    required this.image,
    required this.text,
    required this.title,
  });

  factory TechnoSchema.fromMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String text = data['text'];
    String image = data['image'];

    return TechnoSchema(id: documentId, image: image, text: text, title: title);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'text': text,
      'image': image,
    };
  }
}
