import 'package:ai_rdio/fitsyncshop/screens/home/cartview.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/cartview.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/components/item_card.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ai_rdio/fitsyncshop/constants.dart';
import 'package:ai_rdio/fitsyncshop/models/Product.dart';

import 'components/add_to_cart.dart';
import 'components/color_and_size.dart';
import 'components/counter_with_fav_btn.dart';
import 'components/description.dart';
import 'components/product_title_with_image.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});

  final productInfo product;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // each product have a color
      backgroundColor: HexColor(product.color.toString()),
      appBar: AppBar(
        backgroundColor: HexColor(product.color.toString()),
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            colorFilter: ColorFilter.mode(
                const Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/search.svg",
                colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn)),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/cart.svg",
                colorFilter: ColorFilter.mode(
                    const Color.fromARGB(255, 0, 0, 0), BlendMode.srcIn)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProductCartScreen()));
            },
          ),
          SizedBox(width: kDefaultPaddin / 2)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                      top: size.height * 0.15,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin,
                    ),
                    // height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        ColorAndSize(product: product),
                        SizedBox(height: kDefaultPaddin / 2),
                        Description(product: product),
                        // SizedBox(height: kDefaultPaddin / 2),
                        // CounterWithFavBtn(),
                        SizedBox(height: kDefaultPaddin / 2),
                        AddToCart(product: product)
                      ],
                    ),
                  ),
                  ProductTitleWithImage(product: product)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
