class ImageTechno {
  int? id;
  int? technoId;
  String? directusFilesId;

  ImageTechno({
    this.id,
    this.directusFilesId,
    this.technoId,
  });

  factory ImageTechno.fromMap(Map<String, dynamic> data, documentId) {
    int technoId = data['techno_id'];
    String directusFilesId = data['directus_files_id'];

    return ImageTechno(
      id: documentId,
      directusFilesId: directusFilesId,
      technoId: technoId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'directusFilesId': directusFilesId,
      'technoId': technoId,
    };
  }
}

class TechnoSchema {
  String? id;
  String title;
  String text;
  List<ImageTechno?> images;
  String type;

  /// hs & ss

  TechnoSchema({
    this.id,
    required this.images,
    required this.text,
    required this.title,
    required this.type,
  });

  factory TechnoSchema.fromMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    String text = data['text'];
    List<ImageTechno?> images = data['images'];
    String type = data['type'];

    return TechnoSchema(
        id: documentId, images: images, text: text, title: title, type: type);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'text': text,
      'images': images,
      'type': type,
    };
  }
}
