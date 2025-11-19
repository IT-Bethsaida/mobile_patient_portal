class Patient {
  final String name;
  final int age;
  final String id;

  Patient({required this.name, required this.age, required this.id});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(name: json['name'], age: json['age'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age, 'id': id};
  }
}
