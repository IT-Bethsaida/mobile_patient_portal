class OutpatientHistory {
  final String mrNo;
  final String name;
  final String birthDate;
  final String admissionNo;
  final String admissionDate;
  final String careUnit;
  final String primaryDoctor;
  final String paymentType;
  final String payer;
  final String diagnosisCode;
  final String diagnosis;
  final List<String> subjectives;
  final List<String> objectives;
  final List<String> drugOrders;
  final List<String> laboratoryOrders;
  final List<String> radiologyOrders;

  OutpatientHistory({
    required this.mrNo,
    required this.name,
    required this.birthDate,
    required this.admissionNo,
    required this.admissionDate,
    required this.careUnit,
    required this.primaryDoctor,
    required this.paymentType,
    required this.payer,
    required this.diagnosisCode,
    required this.diagnosis,
    required this.subjectives,
    required this.objectives,
    required this.drugOrders,
    required this.laboratoryOrders,
    required this.radiologyOrders,
  });

  factory OutpatientHistory.fromJson(Map<String, dynamic> json) {
    return OutpatientHistory(
      mrNo: json['mrNo'] as String? ?? '',
      name: json['name'] as String? ?? '',
      birthDate: json['birthDate'] as String? ?? '',
      admissionNo: json['admissionNo'] as String? ?? '',
      admissionDate: json['admissionDate'] as String? ?? '',
      careUnit: json['careUnit'] as String? ?? '',
      primaryDoctor: json['primaryDoctor'] as String? ?? '',
      paymentType: json['paymentType'] as String? ?? '',
      payer: json['payer'] as String? ?? '',
      diagnosisCode: json['diagnosisCode'] as String? ?? '',
      diagnosis: json['diagnosis'] as String? ?? '',
      subjectives:
          (json['subjectives'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      objectives:
          (json['objectives'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      drugOrders:
          (json['drugOrders'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      laboratoryOrders:
          (json['laboratoryOrders'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      radiologyOrders:
          (json['radiologyOrders'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
