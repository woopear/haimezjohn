class ProjetSchema {
  String? id;
  String title;
  String descriptif;
  String lien;
  String lienGithub;
  String image;
  String? techno;

  ProjetSchema({
    this.id,
    required this.descriptif,
    required this.image,
    required this.lien,
    required this.lienGithub,
    this.techno,
    required this.title,
  });

  factory ProjetSchema.fromMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String descriptif = data['descriptif'];
    String lien = data['lien'];
    String lienGithub = data['lienGithub'] ?? '';
    String image = data['image'];
    String techno = data['techno'] ?? '';

    return ProjetSchema(
      id: documentId,
      descriptif: descriptif,
      image: image,
      lien: lien,
      lienGithub: lienGithub,
      techno: techno,
      title: title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'descriptif': descriptif,
      'lien': lien,
      'lienGithub': lienGithub,
      'image': image,
      'techno': techno ?? '',
    };
  }
}
