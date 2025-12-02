import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/models/outpatient_history_model.dart';

class VisitHistoryPage extends StatefulWidget {
  const VisitHistoryPage({super.key});

  @override
  State<VisitHistoryPage> createState() => _VisitHistoryPageState();
}

class _VisitHistoryPageState extends State<VisitHistoryPage> {
  // Sample data migrated from OutpatientHistoryPage
  final List<OutpatientHistory> _histories = [
    OutpatientHistory(
      mrNo: "00-00-41-35",
      name: "ADIFA KHOIRUNNISA",
      birthDate: "20-Des-2020",
      admissionNo: "OP2412240002",
      admissionDate: "24-Des-2024 08.32",
      careUnit: "Anak",
      primaryDoctor: "dr. Viany Rehansyah P,M.Ked(Ped), Sp.A",
      paymentType: "Jaminan",
      payer: "TEKNOLOGI PAMADYA ANALITIKA PT",
      diagnosisCode: "J00",
      diagnosis: "J00-ACUTE NASOPHARYNGITIS [COMMON COLD]",
      subjectives: [
        "orang tua pasien mengatakan batuk berdahak, pilek, radang sejak 1 minggu. demam (-)",
      ],
      objectives: ["faring hiperemis (-)\nnasal Konka hipertrofi (+)"],
      drugOrders: [
        "COMTUSI 60 ML SYR - 3x5cc",
        "CERINI 5 MG / 5 ML SYR 60 ML - 1x5cc",
        "RHINOS JUNIOR SYR - 3x3cc",
      ],
      laboratoryOrders: [],
      radiologyOrders: [],
    ),
    OutpatientHistory(
      mrNo: "00-00-41-35",
      name: "ADIFA KHOIRUNNISA",
      birthDate: "20-Des-2020",
      admissionNo: "OP2504270013",
      admissionDate: "27-Apr-2025 16.15",
      careUnit: "Anak",
      primaryDoctor: "dr. Regia Sabaraty Sinurat, Sp.A",
      paymentType: "Jaminan",
      payer: "TEKNOLOGI PAMADYA ANALITIKA PT",
      diagnosisCode: "J21.9",
      diagnosis: "J21.9-ACUTE BRONCHIOLITIS, UNSPECIFIED",
      subjectives: [
        "Batuk-batuk kenceng seama 7 hari ini, ada pencetus chiki, batuk dahak (+), demam (-), pilek (+)",
      ],
      objectives: ["thorax : SF, ronki (-), wheezing (+)"],
      drugOrders: [
        "LASAL NEBULIZER 2.5 MG - 2x/hari",
        "SPORETIK 100 MG/5 ML - 2x3.5ml",
        "COMTUSI 60 ML SYR - 3x3.5ml",
      ],
      laboratoryOrders: [],
      radiologyOrders: [],
    ),
    OutpatientHistory(
      mrNo: "00-00-41-35",
      name: "ADIFA KHOIRUNNISA",
      birthDate: "20-Des-2020",
      admissionNo: "OP2507220033",
      admissionDate: "22-Jul-2025 13.30",
      careUnit: "Anak",
      primaryDoctor: "dr. Nur Latifah Amilda, Sp.A",
      paymentType: "Jaminan",
      payer: "TEKNOLOGI PAMADYA ANALITIKA PT",
      diagnosisCode: "J06.9",
      diagnosis: "J06.9-ACUTE UPPER RESPIRATORY INFECTION, UNSPECIFIED",
      subjectives: ["3 hari batuk dahak dan pilek, demam (-)"],
      objectives: ["Faring hiperemis (+), T1-1\nSD vesikuler +/+  +/+, ST -/-"],
      drugOrders: [
        "VESTEIN 175 MG/5 ML SYR - 3x2.5ml",
        "CERINI 5 MG / 5 ML SYR - 2x4ml",
        "COLERGIS SYR 60 ML - 3x2.5ml",
      ],
      laboratoryOrders: [],
      radiologyOrders: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Riwayat Kunjungan',
          style: AppTypography.headlineSmall.copyWith(color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: _histories.length,
        itemBuilder: (context, index) {
          final history = _histories[index];
          final isLast = index == _histories.length - 1;
          return _buildTimelineItem(history, isLast, isDarkMode);
        },
      ),
    );
  }

  Widget _buildTimelineItem(
    OutpatientHistory history,
    bool isLast,
    bool isDarkMode,
  ) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Column
          SizedBox(
            width: 50,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isDarkMode ? AppColors.grey700 : AppColors.grey300,
                    ),
                  ),
              ],
            ),
          ),

          // Content Column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Header
                  Text(
                    history.admissionDate,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Card
                  GestureDetector(
                    onTap: () => _showDetailDialog(history, isDarkMode),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDarkMode ? AppColors.grey800 : AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: isDarkMode
                              ? AppColors.grey700
                              : AppColors.grey200,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    history.careUnit,
                                    style: AppTypography.titleMedium.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? AppColors.grey700
                                        : AppColors.grey100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    history.admissionNo,
                                    style: AppTypography.labelSmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: 18,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    history.primaryDoctor,
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: isDarkMode
                                          ? AppColors.white
                                          : AppColors.textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? AppColors.grey900
                                    : AppColors.grey100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.medical_services_outlined,
                                    size: 16,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      history.diagnosis,
                                      style: AppTypography.bodySmall.copyWith(
                                        color: isDarkMode
                                            ? AppColors.grey300
                                            : AppColors.textSecondary,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailDialog(OutpatientHistory history, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.grey900 : AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detail Kunjungan',
                      style: AppTypography.headlineSmall.copyWith(
                        color: isDarkMode
                            ? AppColors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: isDarkMode
                            ? AppColors.white
                            : AppColors.textPrimary,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              const Divider(),

              // Content
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.all(20),
                  children: [
                    _buildDetailSection('Informasi Pasien', [
                      'No. RM: ${history.mrNo}',
                      'Nama: ${history.name.trim()}',
                      'Tanggal Lahir: ${history.birthDate}',
                    ], isDarkMode),
                    const SizedBox(height: 16),
                    _buildDetailSection(
                      'Keluhan (Subjectives)',
                      history.subjectives,
                      isDarkMode,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailSection(
                      'Pemeriksaan (Objectives)',
                      history.objectives,
                      isDarkMode,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailSection(
                      'Resep Obat',
                      history.drugOrders.isNotEmpty
                          ? history.drugOrders
                          : ['Tidak ada resep obat'],
                      isDarkMode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(
    String title,
    List<String> items,
    bool isDarkMode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.titleMedium.copyWith(
            color: isDarkMode ? AppColors.white : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.grey800 : AppColors.grey100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.trim(),
                        style: AppTypography.bodyMedium.copyWith(
                          color: isDarkMode
                              ? AppColors.white
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
