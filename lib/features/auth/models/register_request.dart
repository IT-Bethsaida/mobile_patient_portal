class RegisterRequest {
  final String name;
  final String email;
  final String phoneNumber;
  final String dob;
  final String password;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.dob,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'dob': dob,
      'password': password,
    };
  }
}
