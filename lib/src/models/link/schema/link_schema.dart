class LinkSchema {
  String? id;
  String name;
  String link;

  LinkSchema({
    this.id,
    required this.name,
    required this.link,
  });

  factory LinkSchema.fromMap(Map<String, dynamic> data, documentId) {
    String name = data['name'];
    String link = data['link'];

    return LinkSchema(
      id: documentId,
      name: name,
      link: link,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'link': link,
    };
  }
}
