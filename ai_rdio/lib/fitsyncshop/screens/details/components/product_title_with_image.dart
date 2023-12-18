import 'package:ai_rdio/fitsyncshop/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({super.key, required this.product});

  final productInfo product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.id,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            product.name,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "\₹${product.price}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
              Expanded(
                child: Container(
                  width: 300, // Set the desired width for the small box
                  height: 250, // Set the desired height for the small box
                  child: Hero(
                    tag: "${product.id}",
                    child: Image.network(
                      product.pic,
                      fit: BoxFit.cover, // You can adjust the fit as needed
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
