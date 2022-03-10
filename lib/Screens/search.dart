import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supermarket/Widgets/serviceCardWidget.dart';

import '../Models/product.dart';
import '../Providers/provider/products.dart';
import '../Widgets/feeds_products.dart';
import '../Widgets/searchby_header.dart';
import '../consts/colors.dart';

class Search extends StatefulWidget with ChangeNotifier {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController? _searchTextController;
  List<Product> allProducts = [];
  List<Product> _searchList = [];
  final FocusNode _node = FocusNode();
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    getProducts();

    _searchTextController!.addListener(() {
      setState(() {});
    });
  }

  getProducts() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    snapshot.docs.forEach((element) {
      allProducts.add(Product.fromDocument(element));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final productsList = productsData.products;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: SearchByHeader(
              stackPaddingTop: 100,
              titlePaddingTop: 20,
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Search",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorsConsts.title,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              stackChild: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchTextController,
                  minLines: 1,
                  focusNode: _node,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: 'Search',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    suffixIcon: IconButton(
                      onPressed: _searchTextController!.text.isEmpty
                          ? null
                          : () {
                              _searchTextController!.clear();
                              _node.unfocus();
                            },
                      icon: Icon(Icons.remove_from_queue,
                          color: _searchTextController!.text.isNotEmpty
                              ? Colors.red
                              : Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    _searchTextController!.text.toLowerCase();
                    setState(() {
                      _searchList = productsData.searchQuery(value);

                      // _searchList = allProducts
                      //     .where((element) => element.Name!
                      //         .toLowerCase()
                      //         .contains(
                      //             _searchTextController!.text.toLowerCase()))
                      //     .toList();
                      print(
                          "allProducts:$allProducts _searchList$_searchList ");
                    });
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _searchTextController!.text.isNotEmpty && _searchList.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Icon(
                        Icons.search,
                        size: 60,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'No results found',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                : GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 1,
                    childAspectRatio: 16 / 9,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: List.generate(
                        _searchTextController!.text.isEmpty
                            ? productsList.length
                            : _searchList.length, (index) {
                      return ChangeNotifierProvider.value(
                        value: _searchTextController!.text.isEmpty
                            ? productsList[index]
                            : _searchList[index],
                        child: ServiceCardWidget(),
                      );
                    }),
                  ),
          ),
        ],
      ),
    );
  }
}
