import 'dart:convert';
import 'package:patient_portal/features/hospital_info/models/hospital_model.dart';
import 'package:patient_portal/core/network/api_response.dart';
import 'package:patient_portal/core/network/http_client_with_refresh.dart';
import 'package:patient_portal/core/config/env_config.dart';

class HospitalService {
  static String get baseUrl => EnvConfig.apiBaseUrl;

  static Future<ApiResponse<List<HospitalModel>>> getHospitals() async {
    try {
      final uri = Uri.parse('$baseUrl/hospitals');

      final response = await HttpClientWithRefresh.get(
        uri,
      ).timeout(Duration(seconds: EnvConfig.apiTimeout));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> data = json['data'] ?? [];
        final hospitals = data
            .map((item) => HospitalModel.fromJson(item as Map<String, dynamic>))
            .toList();

        return ApiResponse.success(
          data: hospitals,
          message: json['message'] ?? 'Success',
        );
      }

      if (response.statusCode == 401) {
        return ApiResponse.error(
          message: 'Session expired. Please login again.',
          statusCode: 401,
        );
      }

      return ApiResponse.error(
        message: 'Failed to load hospitals',
        statusCode: response.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(message: 'Error: ${e.toString()}');
    }
  }

  static Future<ApiResponse<HospitalModel>> getHospitalById(String id) async {
    try {
      final uri = Uri.parse('$baseUrl/hospitals/$id');

      final response = await HttpClientWithRefresh.get(
        uri,
      ).timeout(Duration(seconds: EnvConfig.apiTimeout));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final hospital = HospitalModel.fromJson(
          json['data'] as Map<String, dynamic>,
        );

        return ApiResponse.success(
          data: hospital,
          message: json['message'] ?? 'Success',
        );
      }

      if (response.statusCode == 404) {
        return ApiResponse.error(
          message: 'Hospital not found',
          statusCode: 404,
        );
      }

      return ApiResponse.error(
        message: 'Failed to load hospital',
        statusCode: response.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(message: 'Error: ${e.toString()}');
    }
  }
}
