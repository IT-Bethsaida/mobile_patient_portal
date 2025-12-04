class RefreshTokenResponse {
  final String accessToken;
  final String refreshToken;

  RefreshTokenResponse({required this.accessToken, required this.refreshToken});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    // Handle nested data structure from API
    final data = json['data'] as Map<String, dynamic>? ?? json;

    return RefreshTokenResponse(
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
    );
  }
}
