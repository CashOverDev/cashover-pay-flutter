import 'package:cashover_pay_flutter/src/services/cashover_pay_service.dart';
import 'package:flutter/material.dart';
import '../utils/localization.dart';
import '../constants.dart';

/// A Flutter widget that provides a pre-built payment button for CashOver payments.
///
/// This widget renders a styled button that, when pressed, initiates a payment
/// flow through the CashOver payment system. The button automatically handles
/// theme switching, localization, and provides customizable styling options.
///
/// Example usage:
/// ```dart
/// CashOverPayButton(
///   merchantUsername: 'market.example',
///   storeUsername: 'store.example',
///   amount: 49.99,
///   currency: 'USD',
///   metadata: {'orderId': 'ABC123'},
/// )
/// ```
class CashOverPayButton extends StatelessWidget {
  /// The merchant account username where the payment will be received.
  ///
  /// This is obtained from your CashOver merchant dashboard.
  /// Example: 'market.example'
  final String merchantUsername;

  /// The specific store username that will process this transaction.
  ///
  /// Each merchant can have multiple stores. This identifies which store
  /// should handle the payment. Example: 'store.example'
  final String storeUsername;

  /// The transaction amount to be charged.
  ///
  /// Must be a positive number. The precision should match the currency
  /// requirements (e.g., 2 decimal places for USD). For specific precision
  /// requirements by currency, see:
  /// https://docs.cashover.money/guides/merchant/currency-settings
  ///
  /// Example: 49.99
  final double amount;

  /// The currency code for the transaction.
  ///
  /// Should follow ISO 4217 currency codes (e.g., 'USD', 'LBP').
  /// Make sure to use the correct precision for each currency.
  ///
  /// For supported currencies and their precision requirements, see:
  /// https://docs.cashover.money/guides/merchant/currency-settings
  final String currency;

  /// Optional additional information about the transaction.
  ///
  /// This can include order IDs, customer information, session data, or any
  /// other relevant data you want to associate with the payment.
  ///
  /// Example:
  /// ```dart
  /// {
  ///   "orderId": "ORDER_123",
  ///   "customerId": "USER_456",
  ///   "email": "customer@example.com"
  /// }
  /// ```
  final Map<String, dynamic>? metadata;

  /// Optional list of webhook IDs to notify upon payment status changes.
  ///
  /// These webhooks will receive payment status updates, allowing your
  /// backend to react to successful/failed payments in real-time.
  ///
  /// Example: ['webhook_id_1', 'webhook_id_2']
  final List<String>? webhookIds;

  /// The border radius for the button corners.
  ///
  /// Controls how rounded the button appears. Defaults to 8.0 if not specified.
  final double? borderRadius;

  /// Determines how much space the button's child Row should occupy.
  ///
  /// - [MainAxisSize.min]: Button takes only the space it needs
  /// - [MainAxisSize.max]: Button expands to fill available width
  ///
  /// Defaults to [MainAxisSize.min] if not specified.
  final MainAxisSize? mainAxisSize;

  /// How to align the button content horizontally within the available space.
  ///
  /// Only relevant when [mainAxisSize] is [MainAxisSize.max].
  /// Common values:
  /// - [MainAxisAlignment.center]: Centers the content
  /// - [MainAxisAlignment.spaceAround]: Distributes space around elements
  /// - [MainAxisAlignment.spaceBetween]: Puts space between elements
  ///
  /// Defaults to [MainAxisAlignment.spaceAround] if not specified.
  final MainAxisAlignment? mainAxisAlignment;

  /// The language code for button text localization.
  ///
  /// This affects the "Pay" text translation. The button will automatically
  /// use the appropriate translation based on this language code.
  ///
  /// Example: 'en' for English, 'ar' for Arabic, 'fr' for French
  final String? language;

  /// The font size for the button text.
  ///
  /// Controls the size of both "CASH", "VER", and "Pay" text elements.
  /// If not specified, uses the default font size from [CashOverConstants].
  final double? fontSize;

  /// The theme mode for the button appearance.
  ///
  /// - [ThemeMode.light]: Forces light theme colors
  /// - [ThemeMode.dark]: Forces dark theme colors
  /// - [ThemeMode.system]: Follows the system theme (default)
  ///
  /// The button will automatically adjust its colors based on the theme.
  final ThemeMode? theme;

  /// Creates a CashOver payment button.
  ///
  /// The [merchantUsername], [storeUsername], [amount], and [currency]
  /// parameters are required. All other parameters are optional and have
  /// sensible defaults.
  const CashOverPayButton({
    super.key,
    required this.merchantUsername,
    required this.storeUsername,
    required this.amount,
    required this.currency,
    this.metadata,
    this.webhookIds,
    this.borderRadius,
    this.mainAxisSize,
    this.mainAxisAlignment,
    this.language,
    this.fontSize,
    this.theme = ThemeMode.system,
  });

  @override
  Widget build(BuildContext context) {
    // Get the current system theme from the build context
    final systemTheme = Theme.of(context);

    // Determine if we should use dark theme based on the theme parameter
    // Priority: explicit theme setting > system theme preference
    final isDark =
        theme == ThemeMode.system
            ? systemTheme.brightness == Brightness.dark
            : (theme == ThemeMode.light ? false : true);

    // Select appropriate text color based on the determined theme
    final textColor =
        isDark
            ? CashOverConstants.defaultDarkTextColor
            : CashOverConstants.defaultLightTextColor;

    // Select appropriate button background color based on the determined theme
    final buttonColor =
        isDark
            ? CashOverConstants.defaultDarkButtonBackgroundColor
            : CashOverConstants.defaultLightButtonBackgroundColor;

    // Get the singleton instance of the payment service
    final cashOverPayService = CashOverPayService.instance;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          // Use provided border radius or default to 8.0
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        // Standard padding for a comfortable button size
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onPressed: () {
        // Initiate the payment flow when button is pressed
        cashOverPayService.pay(
          merchantUsername: merchantUsername,
          storeUsername: storeUsername,
          amount: amount,
          metadata: metadata,
          currency: currency,
          webhookIds: webhookIds,
        );
      },
      child: Row(
        // Use provided main axis size or default to minimum space needed
        mainAxisSize: mainAxisSize ?? MainAxisSize.min,
        // Use provided alignment or default to space around elements
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceAround,
        children: [
          // "CASH" text - first part of the brand name
          Text(
            "CASH",
            style: TextStyle(
              color: textColor,
              fontSize: fontSize ?? CashOverConstants.defaultFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          // CashOver logo between "CASH" and "VER"
          Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: Image.asset(
              'assets/cashover_logo.png',
              // Scale logo height to match font size
              height: (fontSize ?? CashOverConstants.defaultFontSize),
              // Specify package to load asset from this plugin
              package: 'cashover_pay_flutter',
            ),
          ),
          // "VER" text - second part of the brand name (CASH + VER = CASHOVER)
          Text(
            "VER",
            style: TextStyle(
              color: textColor,
              fontSize: fontSize ?? CashOverConstants.defaultFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Localized "Pay" button text
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              // Translate "pay" based on the current language setting
              CashOverLocalization.translate('pay'),
              style: TextStyle(
                color: textColor,
                fontSize: fontSize ?? CashOverConstants.defaultFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
