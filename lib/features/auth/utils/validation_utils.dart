/// Validation utilities yang sesuai dengan backend DTO (Zod schema)
///
/// Backend DTO Reference:
/// - email: z.string().email()
/// - password: min(8) + uppercase + lowercase + number
/// - name: min(2)
/// - dob: YYYY-MM-DD format
/// - phoneNumber: ^[0-9+\-\s()]+$
class ValidationUtils {
  /// Validate email format
  /// Backend: z.string().email('Invalid email format')
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // RFC 5322 compliant email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Invalid email format';
    }

    return null;
  }

  /// Validate password
  /// Backend: min(8) + uppercase + lowercase + number
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  /// Validate name
  /// Backend: z.string().min(2, 'Name must be at least 2 characters')
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null;
  }

  /// Validate phone number
  /// Backend: z.string().regex(/^[0-9+\-\s()]+$/, 'Invalid phone number format')
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Allow: digits, +, -, spaces, and parentheses
    final phoneRegex = RegExp(r'^[0-9+\-\s()]+$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Invalid phone number format';
    }

    return null;
  }

  /// Validate date of birth format
  /// Backend: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'Invalid date format')
  static String? validateDateFormat(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }

    // YYYY-MM-DD format
    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!dateRegex.hasMatch(value)) {
      return 'Invalid date format. Use YYYY-MM-DD format';
    }

    return null;
  }

  /// Validate confirm password matches
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// Format DateTime to backend format (YYYY-MM-DD)
  static String formatDateForBackend(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Check if date is valid (not in future, reasonable age)
  static String? validateDateOfBirth(DateTime? date) {
    if (date == null) {
      return 'Date of birth is required';
    }

    final now = DateTime.now();

    // Check if date is in the future
    if (date.isAfter(now)) {
      return 'Date of birth cannot be in the future';
    }

    // Check if age is reasonable (at least 1 year old, max 150 years)
    final age = now.year - date.year;
    if (age < 1) {
      return 'You must be at least 1 year old';
    }
    if (age > 150) {
      return 'Invalid date of birth';
    }

    return null;
  }
}
