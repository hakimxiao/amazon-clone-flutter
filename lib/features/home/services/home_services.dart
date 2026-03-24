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

class HomeServices {
  Future<List<Product>> fetchCategoryProduct({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response response = await http.get(
        // URI x SearchParams
        Uri.parse('$uri/api/products?category=$category'),
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
}
