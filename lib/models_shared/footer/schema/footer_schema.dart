class FooterSchema {
  String? id;
  String copyright;

  FooterSchema({
    this.id,
    required this.copyright,
  });

  factory FooterSchema.fromMap(Map<String, dynamic> data, documentId) {
    String copyright = data['copyright'];

    return FooterSchema(id: documentId, copyright: copyright);
  }

  Map<String, dynamic> toMap() {
    return {
      'copyright': copyright,
    };
  }
}
