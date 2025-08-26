# CashOver Pay Flutter

A Flutter package that integrates CashOver's payment system into your Flutter applications, providing a seamless and secure payment experience for your users.
To know more about us visit our website at https://cashover.money/

## Features

✅ **Easy Integration** - Simple setup with just a few lines of code  
✅ **Prebuilt UI Components** - Ready-to-use payment button with customizable styling  
✅ **Secure Payments** - Industry-standard security for all transactions  
✅ **Webhook Support** - Real-time payment status updates via webhooks  
✅ **Metadata Support** - Attach custom data to payments (order IDs, customer info, etc.)  
✅ **Multi-Currency** - Support for various currencies (USD, LBP, and more)  
✅ **Localization** - Multiple language support  
✅ **Theme Customization** - Light/dark theme support with customizable styling

## Getting Started

### Prerequisites

Before using this package, ensure you have:

- A **CashOver merchant account**, sign up [here](https://merchant.cashover.money/)
- At least one **store** created in your merchant dashboard
- Your `merchantUsername` and `storeUsername` credentials

### Installation

Add this package to your project by running:

```shell
flutter pub add cashover_pay_flutter
```

Or add it manually to your `pubspec.yaml`:

```yaml
dependencies:
  cashover_pay_flutter: ^latest_version
```

Then run:

```shell
flutter pub get
```

## Usage

### Basic Implementation

Import the package and use the prebuilt payment button:

```dart
import 'package:cashover_pay_flutter/cashover_pay_flutter.dart';
import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Center(
        child: CashOverPayButton(
          merchantUsername: 'market.example',
          storeUsername: 'store.example',
          amount: 49.99,
          currency: 'USD',
          metadata: {
            "orderId": "A1001",
            "email": "customer@example.com",
            "country": "LB",
            "postalCode": "1300",
          },
          language: 'en',
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          borderRadius: 8,
          theme: ThemeMode.light,
        ),
      ),
    );
  }
}
```

### Configuration Parameters

| Parameter           | Required | Type                 | Description                                             |
| ------------------- | -------- | -------------------- | ------------------------------------------------------- |
| `merchantUsername`  | ✅ Yes   | String               | Your merchant account username (e.g., "market.example") |
| `storeUsername`     | ✅ Yes   | String               | Your store username (e.g., "store.example")             |
| `amount`            | ✅ Yes   | double               | Transaction amount (e.g., 49.99)                        |
| `currency`          | ✅ Yes   | String               | Currency code (e.g., "USD", "LBP")                      |
| `webhookIds`        | ❌ No    | List<String>         | Webhook IDs for payment notifications                   |
| `metadata`          | ❌ No    | Map<String, dynamic> | Additional transaction data                             |
| `language`          | ❌ No    | String               | Language code (e.g., "en")                              |
| `mainAxisSize`      | ❌ No    | MainAxisSize         | Layout size configuration                               |
| `mainAxisAlignment` | ❌ No    | MainAxisAlignment    | Content alignment                                       |
| `borderRadius`      | ❌ No    | double               | Button border radius                                    |
| `theme`             | ❌ No    | ThemeMode            | UI theme (light/dark)                                   |

### Payment Flow

1. **User Interaction**: User taps the CashOver payment button
2. **App Launch**: CashOver Personal app launches automatically
3. **Payment Processing**: User completes payment in the CashOver app
4. **Status Updates**: Your backend receives webhook notifications
5. **UI Update**: Update your app's UI based on payment status

### Webhook Integration

For reliable payment verification, implement webhooks in your backend, more about webhooks [here](https://docs.cashover.money/guides/merchant/webhooks):

```dart
// Example: Adding webhook IDs and metadata for tracking
CashOverPayButton(
  merchantUsername: 'your_merchant',
  storeUsername: 'your_store',
  amount: 99.99,
  currency: 'USD',
  webhookIds: ['webhook_id_1', 'webhook_id_2'], // Your webhook endpoints
  metadata: {
    "orderId": "ORDER_12345",
    "customerId": "CUSTOMER_789",
    "sessionId": "SESSION_ABC",
  },
  // ... other parameters
)
```

Your webhook endpoint will receive payment status updates, allowing you to:

- Update order status in your database
- Send confirmation emails
- Trigger fulfillment processes
- Update your app's UI accordingly

## Example

Check out our [complete example app](https://github.com/CashOverDev/cashover-pay-flutter) on GitHub to see the SDK in action.

## Additional Information

### Support

For technical support, integration help, or general questions:

- 📧 Email: [contactus@cashover.money](mailto:contactus@cashover.money)
- 📚 Documentation: https://docs.cashover.money/
- 🐛 Issues: Report bugs on our [GitHub repository](https://github.com/CashOverDev/cashover-pay-flutter/issues)

### Contributing

We welcome contributions! Please see our contributing guidelines in the repository.

### Currency Precision

Make sure to follow the correct precision for each currency. Refer to our [currency settings documentation](../currency-settings#supported-currencies--precision) for details.

### Security

This package follows industry best practices for payment security. All sensitive operations are handled by the CashOver platform, ensuring your app never directly processes payment credentials.

---

**Made by the CashOver team**
