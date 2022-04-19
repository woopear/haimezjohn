class ProfilSchema {
  String? id;
  String text;
  String image;

  ProfilSchema({
    this.id,
    required this.text,
    required this.image,
  });

  factory ProfilSchema.fromMap(Map<String, dynamic> data, documentId) {
    String text = data['text'];
    String image = data['image'];

    return ProfilSchema(id: documentId, text: text, image: image);
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'image': image,
    };
  }
}
