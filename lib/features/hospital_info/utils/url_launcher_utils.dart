import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Utility class untuk handle URL launching (phone calls, maps, etc)
class UrlLauncherUtils {
  /// Make a phone call
  static Future<void> makePhoneCall(
    BuildContext context,
    String phoneNumber,
  ) async {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[()\-\s]'), '');
    final Uri phoneUri = Uri(scheme: 'tel', path: cleanNumber);

    try {
      await launchUrl(phoneUri);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to make phone call. Please try again.'),
        ),
      );
    }
  }

  /// Open maps with location
  static Future<void> openMaps(
    BuildContext context,
    String name,
    String address,
  ) async {
    // Combine hospital name with address for more specific search results
    final searchQuery = '$name, $address';
    final encodedQuery = Uri.encodeComponent(searchQuery);
    final Uri mapsUri = Uri.parse('geo:0,0?q=$encodedQuery');

    try {
      await launchUrl(mapsUri);
    } catch (e) {
      // Fallback: try to open in browser if maps app fails
      try {
        final Uri fallbackUri = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$encodedQuery',
        );
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      } catch (fallbackError) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Unable to open maps. Please check your internet connection.',
            ),
          ),
        );
      }
    }
  }
}
