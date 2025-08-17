import 'package:cashover_pay_flutter/src/services/cashover_pay_service.dart';
import 'package:flutter/material.dart';
import '../utils/localization.dart';
import '../constants.dart';

class CashOverPayButton extends StatelessWidget {
  final String merchantUsername;
  final String storeUsername;
  final double amount;
  final String currency;
  final Map<String, dynamic>? metadata;
  final List<String>? webhookIds;

  final Color? buttonColor;
  final Color? textColor;
  final double? borderRadius;
  final MainAxisSize? mainAxisSize;
  final MainAxisAlignment? mainAxisAlignment;
  final String? language;
  final double? fontSize;

  const CashOverPayButton({
    super.key,
    required this.merchantUsername,
    required this.storeUsername,
    required this.amount,
    required this.currency,
    this.metadata,
    this.webhookIds,
    this.buttonColor,
    this.textColor,
    this.borderRadius,
    this.mainAxisSize,
    this.mainAxisAlignment,
    this.language,
    this.fontSize,
  });
  @override
  Widget build(BuildContext context) {
    final cashOverPayService = CashOverPayService.instance;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            buttonColor ?? CashOverConstants.defaultButtonBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      onPressed: () {
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
        mainAxisSize: mainAxisSize ?? MainAxisSize.min,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceAround,
        children: [
          Text(
            "CASH",
            style: TextStyle(
              color: textColor ?? CashOverConstants.defaultTextColor,
              fontSize: fontSize ?? CashOverConstants.defaultFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: Image.asset(
              'assets/cashover_logo.png',
              height: (fontSize ?? CashOverConstants.defaultFontSize),
              package: 'cashover_pay_flutter',
            ),
          ),
          Text(
            "VER",
            style: TextStyle(
              color: textColor ?? CashOverConstants.defaultTextColor,
              fontSize: fontSize ?? CashOverConstants.defaultFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              CashOverLocalization.translate('pay'),
              style: TextStyle(
                color: textColor ?? CashOverConstants.defaultTextColor,
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
