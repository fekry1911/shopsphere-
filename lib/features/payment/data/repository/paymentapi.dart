import 'package:dio/dio.dart';
import 'package:shopsphere/core/const/const.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/cubit/appCubit/appCubit.dart';
import '../models/paymentmodel.dart';


class PaymopPayment {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://accept.paymob.com/api/',
          receiveDataWhenStatusError: true,
          headers: {"Content-Type": "application/json"}),
    );
  }

  Future<String> getAuthToken() async {
    Response response =
        await dio!.post("auth/tokens", data: {"api_key": apikey});
    return response.data["token"];
  }

  Future<int> GetOrdreid({required authToken, required int amount}) async {
    Response response = await dio!.post("ecommerce/orders", data: {
      "auth_token": authToken,
      "delivery_needed": true,
      "amount_cents": amount, // EGP 100.00
      "currency": "EGP",
      "items": []
    });
    return response.data["id"];
  }

  Future<String> getPaymentKey(
      {required authToken,
      required int amount,
      required int orderId,
      required PaymentModel details
      }) async {
    Response response = await dio!.post("acceptance/payment_keys", data: {
      "auth_token": authToken,
      "amount_cents": amount,
      "expiration": 3600,
      "order_id": orderId,
      "billing_data": {
        "apartment": "NA",
        "email": details.email,
        "floor": "NA",
        "first_name": details.name,
        "street": details.street,
        "building": "NA",
        "phone_number": details.phone_number,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": details.city,
        "country": "EG",
        "last_name": "Doe",
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": 5017936,
    });
    return response.data["token"];
  }
  void openPaymentURL(String finalToken) async {
    final url = 'https://accept.paymob.com/api/acceptance/iframes/908274?payment_token=$finalToken';

    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch payment page';
    }
  }
}
