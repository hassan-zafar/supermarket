import 'package:badges/badges.dart';
import 'package:supermarket/Screens/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermarket/Widgets/serviceCardWidget.dart';

import '../Models/product.dart';
import '../Providers/provider/cart_provider.dart';
import '../Providers/provider/favs_provider.dart';
import '../Providers/provider/products.dart';
import '../Widgets/feeds_products.dart';
import '../consts/colors.dart';
import 'cart/cart.dart';

class Feeds extends StatefulWidget with ChangeNotifier {
  static const routeName = '/Feeds';

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  Future<void> _getProductsOnRefresh() async {
    await Provider.of<Products>(context, listen: false).fetchProducts();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductsOnRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments;
    final productsProvider = Provider.of<Products>(
      context,
    );
    List<String> allBrands = [];
    List<Product> productsList = productsProvider.products;
    List<Product> tempBrands = productsList.toSet().toList();
    tempBrands.forEach(
      (element) => allBrands.add(element.Brand!),
    );
    allBrands = allBrands.toSet().toList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          title: const Text('All Products'),
          centerTitle: true,
          // actions: [
          //   Consumer<FavsProvider>(
          //     builder: (_, favs, ch) => Badge(
          //       badgeColor: ColorsConsts.cartBadgeColor,
          //       animationType: BadgeAnimationType.slide,
          //       toAnimate: true,
          //       position: BadgePosition.topEnd(top: 5, end: 7),
          //       badgeContent: Text(
          //         favs.getFavsItems.length.toString(),
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       child: IconButton(
          //         icon: Icon(
          //           Icons.favorite_border,
          //           color: ColorsConsts.favColor,
          //         ),
          //         onPressed: () {
          //           Navigator.of(context).pushNamed(WishlistScreen.routeName);
          //         },
          //       ),
          //     ),
          //   ),
          //   Consumer<CartProvider>(
          //     builder: (_, cart, ch) => Badge(
          //       badgeColor: ColorsConsts.cartBadgeColor,
          //       animationType: BadgeAnimationType.slide,
          //       toAnimate: true,
          //       position: BadgePosition.topEnd(top: 5, end: 7),
          //       badgeContent: Text(
          //         cart.getCartItems.length.toString(),
          //         style: TextStyle(color: Colors.white),
          //       ),
          //       child: IconButton(
          //         icon: Icon(
          //           Icons.shopping_cart,
          //           color: ColorsConsts.cartColor,
          //         ),
          //         onPressed: () {
          //           Navigator.of(context).pushNamed(CartScreen.routeName);
          //         },
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: RefreshIndicator(
          onRefresh: _getProductsOnRefresh,
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              // shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                var brandProducts = productsList
                    .where((element) => element.Brand == allBrands[index]);
                List<Product> brandProductsList = brandProducts.toList();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(allBrands[index],
                          style: const TextStyle(fontSize: 22)),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 1,
                      childAspectRatio: 16 / 9,
                      //  240 / 420,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      children:
                          List.generate(brandProductsList.length, (index) {
                        return ChangeNotifierProvider.value(
                          value: brandProductsList[index],
                          child: ServiceCardWidget(),
                        );
                      }),
                    ),
                  ],
                );
              },
              itemCount: allBrands.length,
              // children: [
              //   GridView.count(
              //     crossAxisCount: 2,
              //     childAspectRatio: 240 / 420,
              //     crossAxisSpacing: 8,
              //     mainAxisSpacing: 8,
              //     children: List.generate(productsList.length, (index) {
              //       return ChangeNotifierProvider.value(
              //         value: productsList[index],
              //         child: FeedProducts(),
              //       );
              //     }),
              //   ),
              // ],
            ),
          ),
        ),

        //         StaggeredGridView.countBuilder(
        //           padding: ,
        //   crossAxisCount: 6,
        //   itemCount: 8,
        //   itemBuilder: (BuildContext context, int index) =>FeedProducts(),
        //   staggeredTileBuilder: (int index) =>
        //       new StaggeredTile.count(3, index.isEven ? 4 : 5),
        //   mainAxisSpacing: 8.0,
        //   crossAxisSpacing: 6.0,
        // ),
      ),
    );
  }
}
