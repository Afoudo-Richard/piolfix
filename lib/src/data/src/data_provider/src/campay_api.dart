import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:poilfix/poilfix.dart';

class CamPayApi {
  final String baseUrl = 'https://demo.campay.net/api';

  Uri getUrl({required String url, Map<String, String>? extraParameters}) {
    return Uri.parse('$baseUrl/$url').replace(
      queryParameters: extraParameters,
    );
  }

  // Future<dynamic> getPaymentLink({required String amount}) async {
  //   try {
  //     final response = await http.post(
  //       getUrl(
  //         url: 'get_payment_link/',
  //       ),
  //       body: json.encode({
  //         "amount": amount,
  //         "currency": "XAF",
  //         "description": "Cameroon Hymnal Support",
  //         "redirect_url": "https://arctikq-logistico.netlify.app/",
  //         "failure_redirect_url": "https://arctikq-logistico.netlify.app/",
  //       }),
  //       headers: <String, String>{
  //         "Content-Type": "application/json",
  //         "accept": "application/json",
  //         "Authorization": 'Token 201f1010860a3de98e82c6ac9a1542608203091e',
  //       },
  //     );

  //     switch (response.statusCode) {
  //       case 200:
  //         return json.decode(response.body);
  //       case 401:
  //         throw ErrorGettingPaymentLink(message: json.decode(response.body));
  //       default:
  //         throw ErrorGettingPaymentLink(message: "Error getting payment link");
  //     }

  //     if (response.statusCode == 200) {
  //       return json.decode(response.body);
  //     } else {
  //       final body = response.body;
  //       final error = json.decode(body);
  //       throw ErrorGettingPaymentLink(
  //           message: error); //"Error Accepting or Declining Invite");
  //     }
  //   } catch (e) {
  //     throw ErrorGettingPaymentLink(message: "Error getting payment link");
  //   }
  // }

  Future<dynamic> requestToken() async {
    try {
      final response = await http.post(
        getUrl(
          url: 'token/',
        ),
        body: json.encode({
          "username":
              'rHO-p_Xrxzjgin45MUJky6yXMszR7wMI-HaVEmsIvF75vOxMu5yhR2aFWlenhkq4_4Z2omjlzLjvkf5Rrd_Low',
          "password":
              '6npZEK8q2OXIqRoUzShoN0ZyZbH4EShTPAe2j7cT1TdX6mbWiVyrGXR4aI9ZEGPQmepise9oB7LK5ZJwQLedpw',
        }),
        headers: <String, String>{
          "Content-Type": "application/json",
        },
      );

      switch (response.statusCode) {
        case 200:
          return json.decode(response.body);
        case 401:
          throw ErrorRequestingCamPayToken(message: json.decode(response.body));
        default:
          throw ErrorRequestingCamPayToken(message: "Error getting token");
      }
    } catch (e) {
      throw ErrorRequestingCamPayToken(message: "Error requesting token");
    }
  }

  Future<dynamic> requestPayment({
    required String phone,
    required String amount,
    String description = 'PiolFix service payment.',
  }) async {
    try {
      final tokenResponse = await requestToken();

      try {
        final response = await http.post(
          getUrl(
            url: 'collect/',
          ),
          body: json.encode({
            "amount": amount,
            "currency": "XAF",
            "description": description,
            "from": phone,
          }),
          headers: <String, String>{
            "Content-Type": "application/json",
            "accept": "application/json",
            "Authorization": 'Token ${tokenResponse['token']}',
          },
        );

        switch (response.statusCode) {
          case 200:
            return json.decode(response.body);
          case 401:
            throw ErrorRequestingCamPayPayment(
                message: json.decode(response.body));
          default:
            throw ErrorRequestingCamPayPayment(
                message: "Error getting payment link");
        }
      } catch (e) {
        throw ErrorRequestingCamPayPayment(message: "Error requesting payment");
      }
    } catch (e) {
      throw ErrorRequestingCamPayToken(message: "Error requesting token");
    }
  }
}
