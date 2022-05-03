import 'package:cloud_firestore/cloud_firestore.dart';

class ConditionGeneSchema {
  String? id;
  String title;
  Timestamp? date;

  ConditionGeneSchema({
    this.id,
    required this.title,
    this.date,
  });

  factory ConditionGeneSchema.fromMap(Map<String, dynamic> data, documentId) {
    String title = data['title'];
    Timestamp date = data['date'];

    return ConditionGeneSchema(
      id: documentId,
      title: title,
      date: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date ?? Timestamp.now(),
    };
  }
}
