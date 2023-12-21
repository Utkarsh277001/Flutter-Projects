import 'package:ai_rdio/Utils/Constant.dart';
import 'package:ai_rdio/Utils/Dialog.dart';
import 'package:ai_rdio/Utils/snackBar.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/components/item_card.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/home_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key, required this.product});

  final productInfo product;

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  void seeHistory() {}
  Future uploadproduct() async {
    final prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString("email")!;
    try {
      EasyLoading.show(status: 'Adding Product to Cart...');
      var request = await http.MultipartRequest(
        'POST',
        Uri.parse('${Constant.url}/cart/saveToCart'),
      );
      request.fields["useremail"] = userEmail;
      request.fields["productid"] = widget.product.id;
      request.fields["productname"] = widget.product.name;
      request.fields["price"] = widget.product.price;
      request.fields["image"] = widget.product.pic;

      var res = await request.send();
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Added Successfully..');

        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        msgPop(
          context,
          'Sorry!!',
          "Product with same id already exist",
          DialogType.noHeader,
          seeHistory,
          "OK",
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      showSnackBar(context, e.toString());
    }
  }

  Future userCart() async {
    try {
      EasyLoading.show(status: 'Adding Product to Cart...');
      final prefs = await SharedPreferences.getInstance();
      String userEmail = prefs.getString("email")!;
      var request = await http.MultipartRequest(
        'GET',
        Uri.parse('${Constant.url}/cart/userCart/' + userEmail),
      );
      EasyLoading.dismiss();
      var res = await request.send();
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Added Successfully..');

        EasyLoading.dismiss();
      } else {}
    } catch (e) {
      EasyLoading.dismiss();
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          // Container(
          //   margin: EdgeInsets.only(right: kDefaultPaddin),
          //   height: 50,
          //   width: 58,
          //   // decoration: BoxDecoration(
          //   //   borderRadius: BorderRadius.circular(18),
          //   //   border: Border.all(
          //   //     color: HexColor(widget.product.color),
          //   //   ),
          //   // ),
          //   // child: IconButton(
          //   //   icon: SvgPicture.asset(
          //   //     "assets/icons/add_to_cart.svg",
          //   //     colorFilter: ColorFilter.mode(
          //   //         HexColor(widget.product.color.toString()), BlendMode.srcIn),
          //   //   ),
          //   //   onPressed: () {
          //   //     userCart();
          //   //   },
          //   // ),[]
          // ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                uploadproduct();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                backgroundColor: HexColor(widget.product.color.toString()),
              ),
              child: Text(
                "Add To Cart...".toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
