import 'dart:io';

import 'package:amazon_clone_flutter/constants/error_handler.dart';
import 'package:amazon_clone_flutter/constants/global_variables.dart';
import 'package:amazon_clone_flutter/constants/utils.dart';
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
          Navigator.pop(context);
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
}
