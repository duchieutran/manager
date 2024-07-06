class ModelUser {
  final String name;
  final int age;
  final String address;
  final String email;
  final String image;
  final String id;

  ModelUser(
      {required this.name,
      required this.age,
      required this.address,
      required this.email,
      required this.id,
      required this.image});

  ModelUser.fromJSON(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'],
        address = json['address'],
        email = json['email'],
        image = json['image'],
        id = json['id'];
}
