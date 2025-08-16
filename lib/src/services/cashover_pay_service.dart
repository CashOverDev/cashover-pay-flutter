import 'dart:convert';
import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

/// A singleton service class to handle CashOver payment operations.
///
/// This service provides a centralized way to launch payment URLs for the CashOver
/// platform.
class CashOverService {
  /// Singleton instance of [CashOverService].
  static final CashOverService instance = CashOverService._internal();

  /// Private constructor for singleton pattern.
  CashOverService._internal();

  /// Initiates a payment by launching the CashOver payment URL in the user's browser.
  ///
  /// The URL is constructed based on the provided parameters:
  /// - [merchantUsername]: The username of the merchant.
  /// - [storeUsername]: The username of the store.
  /// - [amount]: Payment amount.
  /// - [currency]: Currency code (e.g., USD, EUR).
  /// - [metadata]: Optional additional data to attach to the payment.
  ///
  /// Throws an exception if the payment URL cannot be launched.
  Future<void> pay({
    required String merchantUsername,
    required String storeUsername,
    required double amount,
    required String currency,
    Map<String, dynamic>? metadata,
  }) async {
    // Construct the payment URL
    final url = _buildPaymentUrl(
      merchantUsername: merchantUsername,
      storeUsername: storeUsername,
      amount: amount,
      currency: currency,
      metadata: metadata,
    );

    final uri = Uri.parse(url);
    // Do not check the canLaunchUrl function as it sometimes gives false results disallowing launching urls.
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      log("Unable to launch url", error: e);
    }
  }

  /// Builds the CashOver payment URL based on the provided parameters.
  ///
  /// Automatically appends the `storeUserName` to the metadata to ensure
  /// the store information is always included.
  ///
  /// Returns the fully formatted URL as a [String].
  String _buildPaymentUrl({
    required String merchantUsername,
    required String storeUsername,
    required double amount,
    required String currency,
    Map<String, dynamic>? metadata,
    List<String>? webhookIds,
  }) {
    // Ensure metadata map exists and include storeUserName
    metadata ??= {};
    metadata['storeUserName'] = storeUsername;

    // Return the complete payment URL
    // Encode metadata as JSON and then URI component
    final encodedMetadata = Uri.encodeComponent(jsonEncode(metadata));

    final url =
        'https://staging.cashover.money/pay?userName=$merchantUsername&amount=$amount&currency=$currency'
        '${webhookIds != null ? '&webhookIds=${webhookIds.join(",")}' : ''}'
        '&metadata=$encodedMetadata';
    return url;
  }
}
