import 'package:cached_network_image/cached_network_image.dart';
import 'package:supermarket/Screens/product_details.dart';
import 'package:supermarket/Utils/utilities.dart';
import 'package:supermarket/consts/consants.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

import '../Models/product.dart';

class ServiceCardWidget extends StatefulWidget {
  @override
  _ServiceCardWidgetState createState() => _ServiceCardWidgetState();
}

class _ServiceCardWidgetState extends State<ServiceCardWidget> {
  @override
  Widget build(BuildContext context) {
    final productsAttributes = Provider.of<Product>(context);
    List<double> allPrices = [];
    allPrices.add(productsAttributes.price_auchan!);
    allPrices.add(productsAttributes.price_continete!);
    allPrices.add(productsAttributes.price_intermarche!);
    allPrices.add(productsAttributes.price_mini!);
    allPrices.add(productsAttributes.price_pingodoce!);
    allPrices.add(productsAttributes.price_spar!);
    allPrices.sort();
    print(productsAttributes);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: productsAttributes.Name);
      },
      child: Container(
        height: 120,
        width: 150,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: (productsAttributes.imageURL == null ||
                        productsAttributes.imageURL!.isEmpty)
                    ? Image.asset(logo, fit: BoxFit.cover)
                    : CachedNetworkImage(
                        imageUrl: productsAttributes.imageURL!,
                        fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(Utilities.padding / 2),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.9)
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        productsAttributes.Name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '\$ ${allPrices.first}-${allPrices.last}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
