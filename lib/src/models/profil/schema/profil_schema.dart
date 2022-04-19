class ProfilSchema {
  String? id;
  String title;
  String text;
  String image;

  ProfilSchema({
    this.id,
    required this.title,
    required this.text,
    required this.image,
  });

  factory ProfilSchema.fromMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String text = data['text'];
    String image = data['image'];

    return ProfilSchema(id: documentId, title: title, text: text, image: image);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'text': text,
      'image': image,
    };
  }
}
