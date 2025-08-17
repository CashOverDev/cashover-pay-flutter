import 'dart:convert';
import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';
import 'package:archive/archive.dart';

/// A singleton service class to handle CashOver payment operations.
///
/// This service provides a centralized way to launch payment URLs for the CashOver
/// platform.
class CashOverPayService {
  /// Singleton instance of [CashOverPayService].
  static final CashOverPayService instance = CashOverPayService._internal();

  /// Private constructor for singleton pattern.
  CashOverPayService._internal();

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
    List<String>? webhookIds,
  }) async {
    // Construct the payment URL
    final uri = _buildPaymentUri(
      merchantUsername: merchantUsername,
      storeUsername: storeUsername,
      amount: amount,
      currency: currency,
      metadata: metadata,
      webhookIds: webhookIds,
    );
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
  /// Returns the fully formatted URI as a [Uri].
  Uri _buildPaymentUri({
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
    final queryParams = <String, String>{
      'userName': merchantUsername,
      'amount': amount.toStringAsFixed(2).replaceAll('.00', ''),
      if (webhookIds?.isNotEmpty ?? false) 'webhookIds': webhookIds!.join(','),
      'metadata': Uri.encodeComponent(jsonEncode(metadata)),
    };

    // Create query string only (no scheme/host/path)
    final queryString = Uri(queryParameters: queryParams).query;

    // Compress with gzip
    final compressed = GZipEncoder().encode(utf8.encode(queryString));

    // Encode with URL-safe Base64, no padding
    final encoded = base64Url.encode(compressed).replaceAll('=', '');
    final uri = Uri(
      scheme: 'https',
      host: 'staging.cashover.money',
      path: 'pay',
      queryParameters: {'session': encoded},
    );

    return uri;
  }
}
