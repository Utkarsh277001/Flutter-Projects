import 'package:ai_rdio/fitsyncshop/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:ai_rdio/fitsyncshop/models/Product.dart';

import '../../../constants.dart';

class Description extends StatelessWidget {
  const Description({super.key, required this.product});

  final productInfo product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: kTextColor),
          children: [
            TextSpan(
              text: "Product Description\n",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "${product.description} ",
            )
          ],
        ),
      ),
    );
  }
}
