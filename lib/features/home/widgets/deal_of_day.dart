import 'package:flutter/material.dart';

class DealOfDay extends StatelessWidget {
  const DealOfDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 10, top: 15),
          child: Text('Deal of the day', style: TextStyle(fontSize: 20)),
        ),
        Image.network(
          'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Y2FyfGVufDB8fDB8fHww',
          height: 235,
          fit: BoxFit.fitHeight,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox(
              height: 235,
              child: Center(child: Icon(Icons.error_outline, color: Colors.grey)),
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
          child: Text('Hakim', maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyfGVufDB8fDB8fHww',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(child: Icon(Icons.error_outline, color: Colors.grey)),
                  );
                },
              ),
              Image.network(
                'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyfGVufDB8fDB8fHww',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(child: Icon(Icons.error_outline, color: Colors.grey)),
                  );
                },
              ),
              Image.network(
                'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyfGVufDB8fDB8fHww',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(child: Icon(Icons.error_outline, color: Colors.grey)),
                  );
                },
              ),
              Image.network(
                'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyfGVufDB8fDB8fHww',
                fit: BoxFit.fitWidth,
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    width: 100,
                    height: 100,
                    child: Center(child: Icon(Icons.error_outline, color: Colors.grey)),
                  );
                },
              ),
            ],
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
    );
  }
}
