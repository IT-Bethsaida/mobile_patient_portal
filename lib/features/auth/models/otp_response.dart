class OtpResponse {
  final String message;
  final String? otpId;

  OtpResponse({required this.message, this.otpId});

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      message: json['message'] as String,
      otpId: json['otpId'] as String?,
    );
  }
}
