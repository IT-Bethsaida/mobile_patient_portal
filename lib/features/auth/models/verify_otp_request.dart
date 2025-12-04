class VerifyOtpRequest {
  final String phoneNumber;
  final String code;

  VerifyOtpRequest({required this.phoneNumber, required this.code});

  Map<String, dynamic> toJson() {
    return {'phoneNumber': phoneNumber, 'code': code};
  }
}
