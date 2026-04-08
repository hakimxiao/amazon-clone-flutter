// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone_flutter/constants/error_handler.dart';
import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/models/order.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AccountServices {
  Future<List<Order>> fetchMyOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];

    try {
      http.Response response = await http.get(
        // URI x SearchParams
        Uri.parse('$uri/api/orders/me'),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () async {
          for (var i = 0; i < jsonDecode(response.body).length; i++) {
            orderList.add(
              Order.fromJson(jsonEncode(jsonDecode(response.body)[i])),
            );
          }
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }

    return orderList;
  }
}
