class CompetenceSchema {
  String? id;
  String title;
  String subTitle;
  String image;
  String cvPdf;

  CompetenceSchema({
    this.id,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.cvPdf,
  });

  factory CompetenceSchema.fromMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String subTitle = data['subTitle'];
    String image = data['image'];
    String cvPdf = data['cvPdf'];

    return CompetenceSchema(
        id: documentId, title: title, subTitle: subTitle, image: image, cvPdf: cvPdf);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle,
      'image': image,
      'cvPdf': cvPdf,
    };
  }
}
