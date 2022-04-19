class CompetenceSchema {
  String? id;
  String title;
  String subTitle;
  String image;

  CompetenceSchema({
    this.id,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  factory CompetenceSchema.fromMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String subTitle = data['subTitle'];
    String image = data['image'];

    return CompetenceSchema(
        id: documentId, title: title, subTitle: subTitle, image: image);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle,
      'image': image,
    };
  }
}
