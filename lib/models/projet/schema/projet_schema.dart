class ProjetSchema {
  String? id;
  String title;
  String descriptif;
  String lien;
  String image;
  String techno;

  ProjetSchema({
    this.id,
    required this.descriptif,
    required this.image,
    required this.lien,
    required this.techno,
    required this.title,
  });

  factory ProjetSchema.fromMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String descriptif = data['descriptif'];
    String lien = data['lien'];
    String image = data['image'];
    String techno = data['techno'];

    return ProjetSchema(
      id: documentId,
      descriptif: descriptif,
      image: image,
      lien: lien,
      techno: techno,
      title: title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'descriptif': descriptif,
      'lien': lien,
      'image': image,
      'techno': techno,
    };
  }
}
