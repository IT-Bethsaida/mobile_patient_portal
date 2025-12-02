/// Model untuk Hospital
class HospitalModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final String phone;
  final String address;
  final double? latitude;
  final double? longitude;
  final String? email;
  final String? website;
  final List<String>? operatingHours;

  HospitalModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.phone,
    required this.address,
    this.latitude,
    this.longitude,
    this.email,
    this.website,
    this.operatingHours,
  });

  /// Factory untuk membuat instance dari JSON (untuk API response)
  factory HospitalModel.fromJson(Map<String, dynamic> json) {
    return HospitalModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      email: json['email'],
      website: json['website'],
      operatingHours: json['operating_hours'] != null
          ? List<String>.from(json['operating_hours'])
          : null,
    );
  }

  /// Convert ke JSON (untuk API request)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'phone': phone,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'email': email,
      'website': website,
      'operating_hours': operatingHours,
    };
  }

  /// Convert ke Map untuk backward compatibility dengan UI yang ada
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'phone': phone,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'email': email,
      'website': website,
      'operating_hours': operatingHours,
    };
  }

  /// Copy with method untuk immutability
  HospitalModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    String? phone,
    String? address,
    double? latitude,
    double? longitude,
    String? email,
    String? website,
    List<String>? operatingHours,
  }) {
    return HospitalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      email: email ?? this.email,
      website: website ?? this.website,
      operatingHours: operatingHours ?? this.operatingHours,
    );
  }

  @override
  String toString() {
    return 'HospitalModel(id: $id, name: $name, phone: $phone)';
  }
}
