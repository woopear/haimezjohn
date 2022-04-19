class ContactSchema {
  String? id;
  String title;
  String subTitle;

  ContactSchema({
    this.id,
    required this.subTitle,
    required this.title,
  });

  factory ContactSchema.fromMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String subTitle = data['subTitle'];

    return ContactSchema(
      id: documentId,
      subTitle: subTitle,
      title: title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      title: title,
      subTitle: subTitle,
    };
  }
}
