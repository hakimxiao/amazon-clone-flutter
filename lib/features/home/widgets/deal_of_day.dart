import 'package:amazon_clone_flutter/common/widgets/loader.dart';
import 'package:amazon_clone_flutter/features/home/services/home_services.dart';
import 'package:amazon_clone_flutter/features/product_detail/screens/product_detail_screen.dart';
import 'package:amazon_clone_flutter/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;

  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreen.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Loader()
        : product!.name.isEmpty
        ? SizedBox()
        : GestureDetector(
            onTap: navigateToDetailScreen,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    'Deal of the day',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Image.network(
                  product!.images[0],
                  height: 235,
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 235,
                      child: Center(
                        child: Icon(Icons.error_outline, color: Colors.grey),
                      ),
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  alignment: Alignment.topLeft,
                  child: Text('\$100', style: TextStyle(fontSize: 18)),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 15, top: 5, right: 40),
                  child: Text(
                    'Hakim',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: product!.images
                        .map(
                          (image) => Image.network(
                            image,
                            fit: BoxFit.fitWidth,
                            width: 100,
                            height: 100,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox(
                                width: 100,
                                height: 100,
                                child: Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'See all deals',
                    style: TextStyle(color: Colors.cyan[800]),
                  ),
                ),
              ],
            ),
          );
  }
}
