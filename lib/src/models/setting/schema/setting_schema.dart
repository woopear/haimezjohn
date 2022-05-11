class SettingSchema {
  String? id;
  bool build;

  SettingSchema({
    this.id,
    this.build = false,
  });

  factory SettingSchema.fromMap(Map<String, dynamic> data, documentId) {
    bool build = data['build'];

    return SettingSchema(
      id: documentId,
      build: build,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'build': build,
    };
  }
}
