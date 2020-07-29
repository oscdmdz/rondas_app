class Registry {
  final int id;
  final String code;
  final String name;
  final String firstName;
  final String lastName;
  final String dni;
  final String photo;

  Registry(
      {this.id,
      this.code,
      this.name,
      this.firstName,
      this.lastName,
      this.dni,
      this.photo});

  factory Registry.fromJson(Map<String, dynamic> json) {
    return Registry(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      dni: json['dni'],
      photo: json['photo'],
    );
  }
}
