
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:monami/students/abonnement/constant/stripe_config.dart';

class StripeGateway {
  Map<String, dynamic>? paymentIntent;
  Map<String, dynamic>? customer;

  static StripeGateway initialize() {
    Stripe.publishableKey = StripeConfig.STRIPE_PUBLISHABLE_KEY;
    return StripeGateway();
  }

  Future<void> makePayment(
    double amount,
    String name,
    String email, {
    String currency = 'USD',
  }) async {
    try {
      customer ??= await retrieveOrCreateCustomer(name, email);
      paymentIntent =
          await createPaymentIntent(amount, currency, customer!['id']);

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              //Gotten from payment intent
              customerEphemeralKeySecret: paymentIntent!['ephemeralKey'],
              customerId: customer!['id'],
              style: ThemeMode.light,
              merchantDisplayName: StripeConfig.STRIPE_MERCHANT_DISPLAY_NAME));

      //STEP 3: Display Payment sheet
      await displayPaymentSheet();
      Fluttertoast.showToast(msg: 'Payment successfully completed');
    } catch (e, stacktrace) {
      if (e is StripeException) {
        Fluttertoast.showToast(
            msg: 'Error from Stripe: ${e.error.localizedMessage}');
      } else {
        Fluttertoast.showToast(msg: "Payment failed!");
      }
      print(stacktrace);
      throw e;
    }
  }

  retrieveOrCreateCustomer(String name, String email) async {
    var customer = await retrieveStripeCustomer(name, email);

    if (customer != null) {
      return customer;
    }
    customer = await createStripeCustomer(name, email);
    if (customer != null) {
      return customer;
    }

    throw 'Failed to register as customer';
  }

  retrieveStripeCustomer(String name, String email) async {
    try {
      final String url =
          'https://api.stripe.com/v1/customers/search?query=email:\'$email\'';
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
        'Content-Type': 'application/x-www-form-urlencoded'
      });
      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['data'];
        if (data.length > 0) {
          return data.first();
        } else {
          return null;
        }
      } else {
        print(json.decode(response.body));
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  createStripeCustomer(String name, String email) async {
    final String url = 'https://api.stripe.com/v1/customers';
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'name': name,
        'email': email,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      return null;
    }
  }

  displayPaymentSheet() async {
    // 3. display the payment sheet.
    await Stripe.instance.presentPaymentSheet();
  }

//create Payment
  createPaymentIntent(double amount, String currency, String customerId) async {
    //Request body
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'customer': customerId
    };

    //Make post request to Stripe
    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );
    return json.decode(response.body);
  }

//calculate Amount
  calculateAmount(double amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.floor().toString();
  }
}
