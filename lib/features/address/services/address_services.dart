// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone_flutter/constants/error_handler.dart';
import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:amazon_clone_flutter/models/user.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode({'address': address}),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)["address"],
          );

          userProvider.setUserFromModel(user);

          return showSnackBar(context, "Address saved successfully!");
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/order'),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'address': address,
          'totalPrice': totalSum,
        }),
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () async {
          showSnackBar(context, 'Your order has been placed successfully!');

          User user = userProvider.user.copyWith(cart: []);

          userProvider.setUserFromModel(user);
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          onSuccess();
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
}
