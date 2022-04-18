class PortfolioSchema {
  String? id;
  String title;
  String subTitle;

  PortfolioSchema({
    this.id,
    required this.subTitle,
    required this.title,
  });

  factory PortfolioSchema.fromMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String subTitle = data['subTitle'];

    return PortfolioSchema(id: documentId, subTitle: subTitle, title: title);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle,
    };
  }
}
