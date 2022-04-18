class InfoPersoSchema {
  String? id;
  String firstname;
  String lastname;
  String address;
  String codePost;
  String city;
  String email;
  String phone;
  String age;
  String permis;

  InfoPersoSchema({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.codePost,
    required this.city,
    required this.email,
    required this.age,
    required this.permis,
    required this.phone,
  });

  factory InfoPersoSchema.fromMap(Map<String, dynamic> data, documentId) {
    String firstname = data['firstname'];
    String lastname = data['lastname'];
    String address = data['address'];
    String codePost = data['codePost'];
    String city = data['city'];
    String email = data['email'];
    String phone = data['phone'];
    String age = data['age'];
    String permis = data['permis'];

    return InfoPersoSchema(
      id: documentId,
      firstname: firstname,
      lastname: lastname,
      address: address,
      codePost: codePost,
      city: city,
      email: email,
      age: age,
      permis: permis,
      phone: phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'address': address,
      'codePost': codePost,
      'city': city,
      'email': email,
      'age': age,
      'permis': permis,
      'phone': phone,
    };
  }
}
