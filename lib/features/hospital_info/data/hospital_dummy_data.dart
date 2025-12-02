import 'package:patient_portal/features/hospital_info/models/hospital_model.dart';
import 'package:patient_portal/core/network/api_response.dart';

/// Dummy data untuk Hospital
/// Ini akan diganti dengan API call yang sebenarnya
class HospitalDummyData {
  /// Simulasi API response untuk mendapatkan list hospital
  static Future<ApiResponse<List<HospitalModel>>> getHospitals() async {
    // Simulasi network delay
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final List<HospitalModel> hospitals = [
        HospitalModel(
          id: '1',
          name: 'Bethsaida Hospital Gading Serpong',
          description:
              'Adalah salah satu unit bisnis dari Paramount Enterprise International dan merupakan Hospital Umum pertama di wilayah Gading Serpong yang diresmikan pada tanggal 12 Desember 2012. Bethsaida Hospital didirikan untuk memenuhi kebutuhan layanan kesehatan bagi masyarakat di seluruh Indonesia, khususnya wilayah provinsi Banten, Jakarta Barat dan Jakarta Selatan yang berbatasan dengan wilayah Tangerang dan sekitarnya. Bethsaida Hospital juga berupaya agar pengobatan pasien dapat dilayani dengan tuntas (One Stop Services).',
          image: 'assets/images/bethsaida_hospital_gading_serpong.jpg',
          phone: '021-29309999',
          address:
              'Jalan Boulevard Raya Gading Serpong Kav. 29 Gading Serpong, Curug Sangereng, Kelapa Dua, Tangerang Regency, Banten 15810',
          latitude: -6.2425,
          longitude: 106.6234,
          email: 'info@bethsaidahospitals.com',
          website: 'https://bethsaidahospitals.com',
          operatingHours: [
            'Senin - Jumat: 08:00 - 20:00',
            'Sabtu: 08:00 - 18:00',
            'Minggu: 08:00 - 14:00',
          ],
        ),
        HospitalModel(
          id: '2',
          name: 'Bethsaida Hospital Serang',
          description:
              'Bethsaida Hospital serang adalah salah satu unit bisnis dari PT Paramount Enterprise International yang telah diresmikan pada tanggal 8 Agustus 2024. Bethsaida Hospital didirikan untuk memenuhi kebutuhan layanan kesehatan bagi masyarakat di wilayah Serang, Cilegon dan sekitarnya. Hal ini tentunya kami persiapkan dengan pemenuhan SDM medis-paramedis serta peralatan canggih untuk menunjang terapi pengobatan yang lebih cepat dan lebih tepat. Bethsaida Hospital Serang juga berupaya agar pengobatan pasien dapat dilayani dengan tuntas dan paripurna (One Stop Services).',
          image: 'assets/images/bethsaida_hospital_serang.jpg',
          phone: '0254-5020-999',
          address:
              'Jl. Lingkar Selatan Cilegon, Desa No.KM. 1, RW.08, Harjatani, Kec. Kramatwatu, Kabupaten Serang, Banten 42161',
          latitude: -6.0789,
          longitude: 106.1234,
          email: 'serang@bethsaidahospitals.com',
          website: 'https://bethsaidahospitals.com/serang',
          operatingHours: [
            'Senin - Jumat: 08:00 - 20:00',
            'Sabtu: 08:00 - 18:00',
            'Minggu: 08:00 - 14:00',
          ],
        ),
      ];

      return ApiResponse.success(
        data: hospitals,
        message: 'Hospitals retrieved successfully',
      );
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to load hospitals',
        error: e.toString(),
      );
    }
  }

  /// Simulasi API response untuk mendapatkan detail hospital by ID
  static Future<ApiResponse<HospitalModel>> getHospitalById(String id) async {
    // Simulasi network delay
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final response = await getHospitals();

      if (response.success && response.data != null) {
        final hospital = response.data!.firstWhere(
          (h) => h.id == id,
          orElse: () => throw Exception('Hospital not found'),
        );

        return ApiResponse.success(
          data: hospital,
          message: 'Hospital detail retrieved successfully',
        );
      }

      return ApiResponse.error(message: 'Hospital not found', statusCode: 404);
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to load hospital detail',
        error: e.toString(),
      );
    }
  }
}
