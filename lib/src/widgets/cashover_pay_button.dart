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

  final Color? buttonColor;
  final Color? textColor;
  final double? borderRadius;
  final String? language;

  const CashOverPayButton({
    super.key,
    required this.merchantUsername,
    required this.storeUsername,
    required this.amount,
    required this.currency,
    this.metadata,
    this.buttonColor,
    this.textColor,
    this.borderRadius,
    this.language,
  });
  @override
  Widget build(BuildContext context) {
    final cashOverPayService = CashOverService.instance;
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
          currency: currency,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/cashover_logo.png',
            height: 36,
            package: 'cashover_pay_flutter',
          ),
          const SizedBox(width: 8),
          Text(
            CashOverLocalization.translate(
              'pay_with_cashover',
              language: language,
            ),
            style: TextStyle(
              color: textColor ?? CashOverConstants.defaultTextColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
