import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patient_portal/features/hospital_info/models/hospital_model.dart';
import 'package:patient_portal/core/network/api_response.dart';
import 'package:patient_portal/core/config/env_config.dart';

class HospitalService {
  static String get baseUrl => EnvConfig.apiBaseUrl;

  // NOTE: Default headers untuk semua request.
  // INFO: Jika jumlah service sudah lebih dari 5 file,
  //       *buat header ini menjadi global* agar tidak duplikasi.
  //       Misalnya dengan membuat class ApiConfig atau ApiHeaders.
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<ApiResponse<List<HospitalModel>>> getHospitals() async {
    try {
      final uri = Uri.parse('$baseUrl/hospitals');

      final response = await http
          .get(uri, headers: _headers)
          .timeout(Duration(seconds: EnvConfig.apiTimeout));

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

      final response = await http
          .get(uri, headers: _headers)
          .timeout(Duration(seconds: EnvConfig.apiTimeout));

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
