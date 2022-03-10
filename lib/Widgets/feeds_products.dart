import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

import '../Models/product.dart';
import '../Providers/provider/cart_provider.dart';
import '../Screens/product_details.dart';
import 'feeds.dialog.dart';

class FeedProducts extends StatefulWidget {
  @override
  _FeedProductsState createState() => _FeedProductsState();
}

class _FeedProductsState extends State<FeedProducts> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final productsAttributes = Provider.of<Product>(context);
    List<double> allPrices = [];
    allPrices.add(productsAttributes.price_auchan!);
    allPrices.add(productsAttributes.price_continete!);
    allPrices.add(productsAttributes.price_intermarche!);
    allPrices.add(productsAttributes.price_mini!);
    allPrices.add(productsAttributes.price_pingodoce!);
    allPrices.add(productsAttributes.price_spar!);
    allPrices.sort();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: productsAttributes.Name),
        child: Container(
          height: 150,
          width: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).backgroundColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: Container(
                          width: double.infinity,
                          height:
                              // 200,
                              MediaQuery.of(context).size.height * 0.28,
                          child: Image.network(
                            productsAttributes.imageURL!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        // bottom: 0,
                        // right: 5,
                        // top: 5,
                        child: Badge(
                          alignment: Alignment.center,
                          toAnimate: true,
                          shape: BadgeShape.square,
                          badgeColor: Colors.pink,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8)),
                          badgeContent: Text(productsAttributes.Brand!,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      productsAttributes.Name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '\$ ${allPrices.first}-${allPrices.last}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   '${productsAttributes.quantity}',
                        //   style: TextStyle(
                        //       fontSize: 12,
                        //       color: Colors.grey,
                        //       fontWeight: FontWeight.w600),
                        // ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => FeedDialog(
                                    productId: productsAttributes.Name!,
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(18.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
