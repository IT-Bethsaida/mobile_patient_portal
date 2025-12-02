/// Generic API Response wrapper untuk konsistensi response handling
class ApiResponse<T> {
  final bool success;
  final int? statusCode;
  final String? message;
  final T? data;
  final dynamic error;

  ApiResponse({
    required this.success,
    this.statusCode,
    this.message,
    this.data,
    this.error,
  });

  /// Factory untuk success response
  factory ApiResponse.success({
    required T data,
    String? message,
    int? statusCode,
  }) {
    return ApiResponse(
      success: true,
      statusCode: statusCode ?? 200,
      message: message ?? 'Success',
      data: data,
    );
  }

  /// Factory untuk error response
  factory ApiResponse.error({
    required String message,
    dynamic error,
    int? statusCode,
  }) {
    return ApiResponse(
      success: false,
      statusCode: statusCode ?? 500,
      message: message,
      error: error,
    );
  }

  /// Factory untuk loading state (optional, untuk future use)
  factory ApiResponse.loading({String? message}) {
    return ApiResponse(success: false, message: message ?? 'Loading...');
  }

  @override
  String toString() {
    return 'ApiResponse(success: $success, statusCode: $statusCode, message: $message)';
  }
}
