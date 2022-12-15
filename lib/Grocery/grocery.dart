import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/Cart/cart_controller.dart';
import 'package:untitled/Favorite/favorite_controller.dart';

import '../model/cart_model.dart';
import '../model/deals_model.dart';

class GroceryScreen extends StatelessWidget {
  GroceryScreen({
    super.key,
  });

  // ProductsModel? productsModel;
  final controller = Get.put(CartController());
  final favController = Get.put(FavoriteController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // readJsonData();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(225, 238, 106, 97),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                        50,
                      ),
                      topLeft: Radius.circular(
                        20,
                      ),
                      bottomLeft: Radius.circular(
                        20,
                      ),
                      bottomRight: Radius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Oxford Street',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 16,
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                fillColor: const Color.fromRGBO(245, 247, 249, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(224, 224, 224, 1)),
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromRGBO(112, 112, 112, 1),
                ),
                hintStyle: const TextStyle(fontSize: 11),
                hintText: 'Search in thousands of products',
              ),
            ),
          ),
          FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/data/add.json'),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                var showData = json.decode(snapshot.data!);
                return Container(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                    minHeight: 50,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: showData['addresses'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(241, 241, 241, 1))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${showData['addresses'][index]['address']}',
                                    ),
                                    SizedBox(
                                      width: 96,
                                      child: Text(
                                        '${showData['addresses'][index]['details']}',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 12),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('x');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder(
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                var showData = json.decode(snapshot.data!);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Explore by Category'),
                      Text(
                        'See All (${showData['categories']!.length})',
                        style: TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('x');
              } else {
                return const CircularProgressIndicator();
              }
            },
            future: DefaultAssetBundle.of(context)
                .loadString('assets/data/products.json'),
          ),
          FutureBuilder(
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                var showData = json.decode(snapshot.data!);
                return Container(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                    minHeight: 50,
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) => Padding(
                      padding: index == 0
                          ? const EdgeInsets.only(left: 16, right: 8)
                          : const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text('${showData['categories'][index]['category']}'),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 0,
                    ),
                    itemCount: showData['categories'].length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('x');
              } else {
                return const CircularProgressIndicator();
              }
            },
            future: DefaultAssetBundle.of(context)
                .loadString('assets/data/products.json'),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Deals of the day'),
          ),
          FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/data/deals.json'),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                var showData = json.decode(snapshot.data!);
                return Container(
                  constraints: const BoxConstraints(
                    maxHeight: 110,
                    minHeight: 50,
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var dealsItem = Deals(
                        id: showData['deals'][index]['id'],
                        title: showData['deals'][index]['title'],
                        price: showData['deals'][index]['price'],
                        category: showData['deals'][index]['category'],
                        description: showData['deals'][index]['description'],
                        oldPrice: showData['deals'][index]['oldPrice'],
                        time: showData['deals'][index]['time'],
                      );

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Obx(
                                    () => IconButton(
                                      onPressed: () async {
                                        if (isExistsInFav(
                                            favController.favList, dealsItem)) {
                                          favController.favList
                                              .remove(dealsItem);
                                        } else {
                                          favController
                                              .addFavItemToList(dealsItem);
                                        }
                                        var jsonDBEncoded =
                                            jsonEncode(favController.favList);
                                        await box.write('Fav', jsonDBEncoded);
                                        controller.cart.refresh();
                                      },
                                      icon: !isExistsInFav(
                                              favController.favList, dealsItem)
                                          ? const Icon(
                                              Icons.favorite_border,
                                              color: Colors.grey,
                                              size: 15,
                                            )
                                          : const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                              size: 15,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${showData['deals'][index]['title']}'),
                              Text(
                                  '${showData['deals'][index]['description']}'),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined),
                                  Text(
                                      '${showData['deals'][index]['time']} Away'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$ ${showData['deals'][index]['price']}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '\$ ${showData['deals'][index]['oldPrice']}',
                                    style: const TextStyle(),
                                  ),
                                  const SizedBox(
                                    width: 32,
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        var cartItem = CartModel(
                                          quantity: 1,
                                          id: showData['deals'][index]['id'],
                                          title: showData['deals'][index]
                                              ['title'],
                                          price: showData['deals'][index]
                                              ['price'],
                                          category: showData['deals'][index]
                                              ['category'],
                                        );
                                        if (isExistsInCart(
                                            controller.cart, cartItem)) {
                                          var productUpdate = controller.cart
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  showData['deals'][index]
                                                      ['id']);
                                          productUpdate.quantity++;
                                        } else {
                                          controller.cart.add(cartItem);
                                        }
                                        var jsonDBEncoded =
                                            jsonEncode(controller.cart);
                                        await box.write('Cart', jsonDBEncoded);
                                        controller.cart.refresh();
                                      },
                                      icon: const Icon(Icons.add_shopping_cart))
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 16,
                    ),
                    itemCount: showData['deals'].length,
                    // itemCount: showData.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                  ),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${snapshot.error}'),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 106,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.pink.shade100),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mega',
                            style: TextStyle(color: Colors.red, fontSize: 11),
                          ),
                          Text(
                            'WHOPPER',
                            style: TextStyle(
                                color: Colors.blue.shade800, fontSize: 24),
                          ),
                          Row(
                            children: const [
                              Text(
                                '\$ 12',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '\$ 18',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Text(
                            '* Available until 24 December 2020',
                            style: TextStyle(color: Colors.white, fontSize: 9),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<List<Products>> readJsonDatabase() async{
  //    final rawData = await rootBundle.loadString('assets/data/products.json');
  //    final list = json.decode(rawData) as List<dynamic>;
  //    return list.map((e) => Products.fromJson(e)).toList();
  // }
  bool isExistsInCart(RxList<CartModel> cart, CartModel cartItem) {
    // return cart.contains(cartItem);
    return cart.isEmpty
        ? false
        : cart.any((element) => element.id == cartItem.id)
            ? true
            : false;
  }

  bool isExistsInFav(RxList<Deals> fav, Deals favItem) {
    return fav.isEmpty
        ? false
        : fav.any((element) => element.id == favItem.id)
            ? true
            : false;
  }
}
