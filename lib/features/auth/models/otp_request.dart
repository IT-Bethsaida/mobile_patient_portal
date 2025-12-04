class OtpRequest {
  final String phoneNumber;

  OtpRequest({required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {'phoneNumber': phoneNumber};
  }
}
