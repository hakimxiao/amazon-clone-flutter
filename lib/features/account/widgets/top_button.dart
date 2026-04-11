import 'package:amazon_clone_flutter/features/account/services/account_servicess.dart';
import 'package:amazon_clone_flutter/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {
  const TopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Orders', onTap: () {}),
            AccountButton(text: 'Turn Seller', onTap: () {}),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Logout',
              onTap: () => AccountServices().logOut(context),
            ),
            AccountButton(text: 'Your Wish List', onTap: () {}),
          ],
        ),
      ],
    );
  }
}
