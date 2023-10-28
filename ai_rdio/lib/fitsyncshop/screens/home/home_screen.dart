import 'dart:async';

import 'package:ai_rdio/fitsyncshop/constants.dart';
import 'package:ai_rdio/fitsyncshop/models/Product.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/cartview.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/components/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogApp extends StatefulWidget {
  @override
  State<CatalogApp> createState() => _CatalogAppState();
}

class _CatalogAppState extends State<CatalogApp> {
  // final List<Product> products = [
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'FitSync - Shop',
            style: TextStyle(color: Colors.black, letterSpacing: 1),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            // IconButton(
            //   icon: SvgPicture.asset(
            //     "assets/icons/search.svg",
            //     colorFilter: ColorFilter.mode(kTextColor, BlendMode.srcIn),
            //   ),
            //   onPressed: () {},
            // ),
            GestureDetector(
              child: IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/cart.svg",
                    colorFilter: ColorFilter.mode(kTextColor, BlendMode.srcIn),
                  ),
                  onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProductCartScreen()))
                      }),
            ),

            SizedBox(width: kDefaultPaddin / 2)
          ],
        ),
        body: CatalogView(products: products),
      ),
    );
  }
}

class CatalogView extends StatefulWidget {
  final List<Product> products;

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
                  .where((product) => product.title == category)
                  .toList();

              return ProductListView(products: filteredProducts);
            },
          ),
        ),
      ],
    );
  }

  List<String> extractCategories(List<Product> products) {
    return products.map((product) => product.title).toSet().toList();
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
  final List<Product> products;

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
                builder: (context) => ProductCartScreen(),
                // builder: (context) => DetailsScreen(
                //   product: products[index],
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
