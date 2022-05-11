class ArticleConditionSchema {
  String? id;
  String title;
  String text;

  ArticleConditionSchema({
    this.id,
    required this.text,
    required this.title,
  });

  factory ArticleConditionSchema.fromMap(
    Map<String, dynamic> data,
    documentId,
  ) {
    String title = data['title'];
    String text = data['text'];

    return ArticleConditionSchema(
      id: documentId,
      text: text,
      title: title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'title': title,
    };
  }
}
