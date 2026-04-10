// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone_flutter/constants/error_handler.dart';
import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
import 'package:amazon_clone_flutter/features/admin/models/sales.dart';
import 'package:amazon_clone_flutter/models/order.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:amazon_clone_flutter/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('daais3bal', 'amazon-clone');

      List<String> imageUrl = [];

      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );

        imageUrl.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrl,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, 'Product added successfully!');
          Navigator.pop(context, true);
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

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> ordersList = [];

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-orders'),
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

          ordersList = data.map((e) {
            return Order.fromJson(jsonEncode(e));
          }).toList();
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }

    return ordersList;
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode({'id': order.id, 'status': status}),
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

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    num totalEarning = 0;

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/analytics'),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () async {
          var res = jsonDecode(response.body);
          totalEarning = res["totalEarnings"] ?? 0;
          sales = [
            Sales("Mobiles", res["mobileEarnings"] ?? 0),
            Sales("Essentials", res["essentialsEarnings"] ?? 0),
            Sales("Appliances", res["appliancesEarnings"] ?? 0),
            Sales("Books", res["booksEarnings"] ?? 0),
            Sales("Fashion", res["fashionEarnings"] ?? 0),
          ];
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }

    return {'sales': sales, 'totalEarnings': totalEarning};
  }
}
