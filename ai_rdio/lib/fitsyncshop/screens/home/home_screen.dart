import 'dart:async';
import 'dart:convert';
import 'package:ai_rdio/fitsyncshop/screens/details/details_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:ai_rdio/Utils/Constant.dart';
import 'package:ai_rdio/fitsyncshop/constants.dart';

import 'package:ai_rdio/fitsyncshop/screens/home/cartview.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/components/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CatalogApp extends StatefulWidget {
  @override
  State<CatalogApp> createState() => _CatalogAppState();
}

class _CatalogAppState extends State<CatalogApp> {
  List<productInfo> _productData = [];

  Future<void> _getGyms() async {
    String url = '${Constant.url}/shop/getProduct';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // var jsonData = json.decode(response.body);
        EasyLoading.dismiss();
        setState(() {
          _productData = (json.decode(response.body) as List)
              .map((data) => productInfo.fromJson(data))
              .toList();
          print("successfully retrive");
          print(_productData);
          print(_productData.length);
        });
      } else {
        print('Failed to load gyms: ${response.statusCode}');
      }
    } catch (error) {
      print('Error loading gyms: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _getGyms();
  }

  // final List<Product> products = [
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'FitSync - Shop',
            style: TextStyle(color: Colors.black, letterSpacing: 1),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/cart.svg",
                  colorFilter: ColorFilter.mode(kTextColor, BlendMode.srcIn),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => ProductCartScreen()));
                }),
            // GestureDetector(
            //   child: IconButton(
            //       icon: Icon(Icons.category,
            //           size: 18, color: const Color.fromARGB(255, 226, 8, 8)),
            //       onPressed: () => {
            //             Navigator.of(context).push(MaterialPageRoute(
            //                 builder: (BuildContext context) =>
            //                     ProductCartScreen()))
            //           }),
            // ),

            SizedBox(width: kDefaultPaddin / 2)
          ],
        ),
        body: CatalogView(products: _productData),
      ),
    );
  }
}

class CatalogView extends StatefulWidget {
  final List<productInfo> products;

  CatalogView({required this.products});

  @override
  _CatalogViewState createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  late PageController _pageController;
  int selectedIndex = 0;
  ScrollController _categoryListController = ScrollController();

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: selectedIndex);

    // Listen to page changes and update the selectedIndex
    _pageController.addListener(() {
      setState(() {
        selectedIndex = _pageController.page!.round();
        _categoryListController.animateTo(
          selectedIndex * 100.0, // 100 is an approximate item height
          duration: Duration(milliseconds: 100),
          curve: Curves.bounceIn,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        ),
        CategoryList(
          categories: extractCategories(widget.products),
          pageController: _pageController,
          selectedIndex: selectedIndex,
          onCategorySelected: (int index) {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
          },
          scrollController: _categoryListController,
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: extractCategories(widget.products).length,
            itemBuilder: (context, index) {
              final category = extractCategories(widget.products)[index];
              final filteredProducts = widget.products
                  .where((product) => product.category == category)
                  .toList();

              return ProductListView(products: filteredProducts);
            },
          ),
        ),
      ],
    );
  }

  List<String> extractCategories(List<productInfo> products) {
    return products
        .map((product) => product.category.toString())
        .toSet()
        .toList();
  }
}

class CategoryList extends StatelessWidget {
  final List<String> categories;
  final PageController pageController;
  final int selectedIndex;
  final Function(int) onCategorySelected;
  final ScrollController scrollController;

  CategoryList(
      {required this.categories,
      required this.pageController,
      required this.selectedIndex,
      required this.onCategorySelected,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 0,
          ),
        ),
      ),
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              if (index >= 0 && index < categories.length) {
                onCategorySelected(index);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: isSelected
                  ? BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.lightBlue,
                          width: 4,
                        ),
                      ),
                    )
                  : null,
              child: Chip(
                backgroundColor: isSelected
                    ? Color.fromARGB(255, 255, 255, 255)
                    : Color.fromARGB(255, 255, 255, 255),

                elevation: isSelected ? 10 : 2.3,
                shadowColor: isSelected
                    ? Color.fromARGB(255, 228, 228, 228)
                    : Colors.grey, // Change the background color here

                label: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.lightBlue : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProductListView extends StatelessWidget {
  final List<productInfo> products;

  ProductListView({required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: kDefaultPaddin,
          crossAxisSpacing: kDefaultPaddin,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ItemCard(
            product: products[index],
            press: () => Navigator.push(
              context,
              MaterialPageRoute(
                // builder: (context) => ProductCartScreen(),
                builder: (context) => DetailsScreen(
                  product: products[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class productInfo {
  var id;
  final String category;
  final String price;
  final String name;
  final String size;

  final String description;

  var color;
  final String pic;

  productInfo({
    required this.id,
    required this.category,
    required this.price,
    required this.name,
    required this.size,
    required this.description,
    required this.color,
    required this.pic,
  });

  factory productInfo.fromJson(Map<String, dynamic> json) {
    return productInfo(
      id: json['productid'],
      category: json['category'],
      name: json['productname'],
      price: json['price'],
      size: json['size'],
      description: json['description'],
      color: json['color'],
      pic: json['image'],
    );
  }
}
