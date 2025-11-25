import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/app_theme.dart';

class DoctorDetailPage extends StatefulWidget {
  final Map<String, dynamic> doctor;
  final String hospital;
  final String specialty;

  const DoctorDetailPage({
    super.key,
    required this.doctor,
    required this.hospital,
    required this.specialty,
  });

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  String? _selectedPatient;
  String _notes = '';
  String _selectedTimePeriod = 'Pagi'; // Pagi, Siang, Sore, Malam
  final List<DateTime> _weekDates = [];

  // Mock doctor schedules with time ranges and interval settings
  // In real app, this would come from API
  final Map<String, Map<String, dynamic>> doctorSchedules = {
    'Dr. Sarah Johnson': {
      'schedules': [
        {'start': '08:00', 'end': '12:00'},
        {'start': '14:00', 'end': '16:00'},
      ],
      'intervalMinutes': 10, // Can be changed by admin
    },
    'Dr. Robert Lee': {
      'schedules': [
        {'start': '09:00', 'end': '11:00'},
        {'start': '13:00', 'end': '15:00'},
      ],
      'intervalMinutes': 15,
    },
    'Dr. Michael Chen': {
      'schedules': [
        {'start': '08:00', 'end': '10:00'},
        {'start': '14:00', 'end': '16:00'},
      ],
      'intervalMinutes': 10,
    },
    'Dr. Emily Davis': {
      'schedules': [
        {'start': '09:00', 'end': '11:00'},
        {'start': '13:00', 'end': '15:00'},
      ],
      'intervalMinutes': 15,
    },
    'Dr. Amanda Williams': {
      'schedules': [
        {'start': '08:00', 'end': '12:00'},
      ],
      'intervalMinutes': 10,
    },
    'Dr. James Brown': {
      'schedules': [
        {'start': '13:00', 'end': '16:00'},
      ],
      'intervalMinutes': 10,
    },
    'Dr. David Wilson': {
      'schedules': [
        {'start': '08:00', 'end': '10:00'},
        {'start': '14:00', 'end': '15:00'},
      ],
      'intervalMinutes': 15,
    },
    'Dr. Lisa Anderson': {
      'schedules': [
        {'start': '09:00', 'end': '11:00'},
        {'start': '15:00', 'end': '16:00'},
      ],
      'intervalMinutes': 10,
    },
    'Dr. Thomas Martinez': {
      'schedules': [
        {'start': '08:00', 'end': '09:00'},
        {'start': '14:00', 'end': '15:00'},
      ],
      'intervalMinutes': 15,
    },
    'Dr. Patricia Taylor': {
      'schedules': [
        {'start': '10:00', 'end': '11:00'},
        {'start': '13:00', 'end': '16:00'},
      ],
      'intervalMinutes': 10,
    },
    'Dr. John Smith': {
      'schedules': [
        {'start': '08:00', 'end': '12:00'},
        {'start': '14:00', 'end': '15:00'},
      ],
      'intervalMinutes': 10,
    },
    'Dr. Mary Johnson': {
      'schedules': [
        {'start': '09:00', 'end': '11:00'},
        {'start': '13:00', 'end': '15:00'},
      ],
      'intervalMinutes': 15,
    },
    'Dr. Richard White': {
      'schedules': [
        {'start': '08:00', 'end': '10:00'},
        {'start': '14:00', 'end': '16:00'},
      ],
      'intervalMinutes': 10,
    },
    'Dr. Jennifer Garcia': {
      'schedules': [
        {'start': '09:00', 'end': '11:00'},
        {'start': '13:00', 'end': '15:00'},
      ],
      'intervalMinutes': 15,
    },
    'Dr. William Garcia': {
      'schedules': [
        {'start': '08:00', 'end': '10:00'},
        {'start': '13:00', 'end': '15:00'},
      ],
      'intervalMinutes': 10,
    },
    'Dr. Charles Robinson': {
      'schedules': [
        {'start': '09:00', 'end': '11:00'},
        {'start': '14:00', 'end': '16:00'},
      ],
      'intervalMinutes': 15,
    },
    'Dr. Nancy Clark': {
      'schedules': [
        {'start': '08:00', 'end': '10:00'},
        {'start': '13:00', 'end': '15:00'},
      ],
      'intervalMinutes': 10,
    },
    'Dr. Michael Brown': {
      'schedules': [
        {'start': '08:00', 'end': '10:00'},
        {'start': '14:00', 'end': '15:00'},
      ],
      'intervalMinutes': 10,
    },
  };

  // Mock patient list
  final List<Map<String, String>> patients = [
    {'name': 'John Doe (Myself)', 'relation': 'Self', 'id': '1'},
    {'name': 'Jane Doe (Wife)', 'relation': 'Wife', 'id': '2'},
    {'name': 'Jimmy Doe (Son)', 'relation': 'Son', 'id': '3'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeWeekDates();
  }

  void _initializeWeekDates() {
    final now = DateTime.now();
    _weekDates.clear();
    for (int i = 0; i < 7; i++) {
      _weekDates.add(now.add(Duration(days: i)));
    }
    _selectedDate = now;
  }

  List<String> get availableTimeSlots {
    final doctorSchedule = doctorSchedules[widget.doctor['name']];
    if (doctorSchedule == null) return [];

    final schedules = doctorSchedule['schedules'] as List<dynamic>;
    final intervalMinutes = doctorSchedule['intervalMinutes'] as int;

    List<String> slots = [];

    // Time period ranges
    Map<String, List<int>> periodRanges = {
      'Pagi': [7, 11], // 07:00 - 11:00
      'Siang': [11, 15], // 11:00 - 15:00
      'Sore': [15, 18], // 15:00 - 18:00
      'Malam': [18, 22], // 18:00 - 22:00
    };

    final selectedRange = periodRanges[_selectedTimePeriod]!;
    final minHour = selectedRange[0];
    final maxHour = selectedRange[1];

    for (var schedule in schedules) {
      final scheduleMap = schedule as Map<String, dynamic>;
      final startTime = scheduleMap['start'] as String;
      final endTime = scheduleMap['end'] as String;

      final startParts = startTime.split(':');
      final endParts = endTime.split(':');

      int startHour = int.parse(startParts[0]);
      int startMinute = int.parse(startParts[1]);
      int endHour = int.parse(endParts[0]);
      int endMinute = int.parse(endParts[1]);

      DateTime startDateTime = DateTime(2024, 1, 1, startHour, startMinute);
      DateTime endDateTime = DateTime(2024, 1, 1, endHour, endMinute);

      while (startDateTime.isBefore(endDateTime)) {
        // Filter by selected time period
        if (startDateTime.hour >= minHour && startDateTime.hour < maxHour) {
          String timeFormatted = _formatTimeSlotSimple(startDateTime);
          slots.add(timeFormatted);
        }

        startDateTime = startDateTime.add(Duration(minutes: intervalMinutes));
      }
    }

    return slots;
  }

  String _formatTimeSlotSimple(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  int _getAvailableSlotsForDate(DateTime date) {
    // Mock data - in real app, this would come from API
    // Return random availability for demo
    if (date.weekday == DateTime.sunday) return 0;
    if (date.weekday == DateTime.saturday) return 0;
    return 10; // Available slots
  }

  String _getDayName(DateTime date) {
    const days = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
    ];
    return days[date.weekday % 7];
  }

  Widget _buildTimePeriodTab(String period, bool isDarkMode) {
    final isSelected = _selectedTimePeriod == period;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTimePeriod = period;
            _selectedTimeSlot = null; // Reset time slot when period changes
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : (isDarkMode ? AppColors.grey800 : AppColors.grey200),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            period,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(
              color: isSelected ? AppColors.white : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        title: Text(
          'Doctor Details',
          style: AppTypography.headlineMedium.copyWith(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Profile Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.screenPaddingHorizontal),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.white.withValues(alpha: 0.2),
                    child: Icon(Icons.person, size: 60, color: AppColors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.doctor['name'],
                    style: AppTypography.headlineMedium.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.specialty,
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildInfoChip(
                        Icons.work_outline,
                        widget.doctor['experience'],
                        isDarkMode,
                      ),
                      const SizedBox(width: 12),
                      _buildInfoChip(
                        Icons.star,
                        '${widget.doctor['rating']} (${widget.doctor['reviews']})',
                        isDarkMode,
                        iconColor: Colors.amber,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_hospital,
                          size: 16,
                          color: AppColors.white,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.hospital,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.doctor['education'],
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.white.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 0),
                ],
              ),
            ),

            // Schedule Section with Curved Top
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.grey900 : AppColors.grey100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.screenPaddingHorizontal,
                  24,
                  AppTheme.screenPaddingHorizontal,
                  24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Date & Time',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Custom Date Picker
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _weekDates.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final date = _weekDates[index];
                          final isSelected =
                              _selectedDate != null &&
                              date.day == _selectedDate!.day &&
                              date.month == _selectedDate!.month;
                          final availableSlots = _getAvailableSlotsForDate(
                            date,
                          );
                          final isAvailable = availableSlots > 0;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDate = date;
                                _selectedTimeSlot = null;
                              });
                            },
                            child: Container(
                              width: 70,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : (isDarkMode
                                          ? AppColors.grey700
                                          : AppColors.grey200),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _getDayName(date),
                                    style: AppTypography.bodySmall.copyWith(
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.textSecondary,
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${date.day}',
                                    style: AppTypography.headlineSmall.copyWith(
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.textPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isAvailable
                                        ? 'Available'
                                        : '$availableSlots slot',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.textSecondary,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    if (_selectedDate != null) ...[
                      const SizedBox(height: 24),

                      // Time Period Tabs
                      Row(
                        children: [
                          _buildTimePeriodTab('Pagi', isDarkMode),
                          const SizedBox(width: 8),
                          _buildTimePeriodTab('Siang', isDarkMode),
                          const SizedBox(width: 8),
                          _buildTimePeriodTab('Sore', isDarkMode),
                          const SizedBox(width: 8),
                          _buildTimePeriodTab('Malam', isDarkMode),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Time Slots Grid
                      availableTimeSlots.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 32,
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.event_busy,
                                      size: 64,
                                      color: AppColors.textSecondary.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Jadwal tidak ditemukan',
                                      style: AppTypography.titleMedium.copyWith(
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Tidak ada jadwal tersedia untuk periode waktu ini',
                                      style: AppTypography.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 2.5,
                                  ),
                              itemCount: availableTimeSlots.length,
                              itemBuilder: (context, index) {
                                final slot = availableTimeSlots[index];
                                final isSelected = _selectedTimeSlot == slot;
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedTimeSlot = slot;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary
                                          : (isDarkMode
                                                ? AppColors.grey800
                                                : AppColors.white),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.primary
                                            : (isDarkMode
                                                  ? AppColors.grey700
                                                  : AppColors.grey300),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        slot,
                                        style: AppTypography.bodyMedium
                                            .copyWith(
                                              color: isSelected
                                                  ? AppColors.white
                                                  : AppColors.textPrimary,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],

                    // Patient Selection
                    if (_selectedTimeSlot != null) ...[
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Patient',
                            style: AppTypography.titleMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () =>
                                _showAddPatientDialog(context, isDarkMode),
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text('Add Patient'),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...patients.map(
                        (patient) => _buildPatientCard(patient, isDarkMode),
                      ),

                      const SizedBox(height: 20),

                      // Notes
                      Text(
                        'Additional Notes (Optional)',
                        style: AppTypography.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        onChanged: (value) => _notes = value,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Add any notes or special requests',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: isDarkMode
                              ? AppColors.grey800
                              : AppColors.grey100,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Confirm Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _selectedPatient == null
                              ? null
                              : _confirmBooking,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            disabledBackgroundColor: AppColors.grey400,
                          ),
                          child: Text(
                            'Confirm Booking',
                            style: AppTypography.button.copyWith(fontSize: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    IconData icon,
    String text,
    bool isDarkMode, {
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor ?? AppColors.white),
          const SizedBox(width: 6),
          Text(
            text,
            style: AppTypography.bodySmall.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard(Map<String, String> patient, bool isDarkMode) {
    final isSelected = _selectedPatient == patient['id'];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.grey800 : AppColors.white,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.grey300,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPatient = patient['id'];
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Icon(Icons.person, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient['name'] ?? '',
                      style: AppTypography.titleMedium.copyWith(
                        color: isDarkMode
                            ? AppColors.white
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      patient['relation'] ?? '',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: AppColors.primary, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmBooking() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                size: 64,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Appointment Confirmed!',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Your appointment with ${widget.doctor['name']} has been successfully booked.',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Close all dialogs and return to appointment list
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pop(); // Go back to main wrapper
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPatientDialog(BuildContext context, bool isDarkMode) {
    String newPatientName = '';
    String newPatientRelation = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? AppColors.grey800 : AppColors.white,
        title: Text(
          'Add New Patient',
          style: AppTypography.titleLarge.copyWith(
            color: isDarkMode ? AppColors.white : AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => newPatientName = value,
              decoration: InputDecoration(
                labelText: 'Patient Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => newPatientRelation = value,
              decoration: InputDecoration(
                labelText: 'Relation (e.g., Son, Daughter, Parent)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (newPatientName.isNotEmpty && newPatientRelation.isNotEmpty) {
                setState(() {
                  patients.add({
                    'name': '$newPatientName ($newPatientRelation)',
                    'relation': newPatientRelation,
                    'id': (patients.length + 1).toString(),
                  });
                });
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
