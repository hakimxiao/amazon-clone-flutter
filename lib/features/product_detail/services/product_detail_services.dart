// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone_flutter/constants/error_handler.dart';
import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode({"id": product.id, "rating": rating}),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, 'Product ratting successfully!');
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () async {
          final List data = jsonDecode(response.body);

          productList = data.map((e) {
            return Product.fromJson(jsonEncode(e));
          }).toList();
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }

    return productList;
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
