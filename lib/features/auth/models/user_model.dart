class UserModel {
  final String id;
  final String email;
  final String name;
  final String? dob;
  final String phoneNumber;
  final String role;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.dob,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      dob: json['dob'] as String?,
      phoneNumber: json['phoneNumber'] as String,
      role: json['role'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // @override
  // String toString() {
  //   return 'UserModel{\n'
  //       '  id: $id,\n'
  //       '  email: $email,\n'
  //       '  name: $name,\n'
  //       '  dob: $dob,\n'
  //       '  phoneNumber: $phoneNumber,\n'
  //       '  role: $role,\n'
  //       '  createdAt: $createdAt\n'
  //       '}';
  // }
}
