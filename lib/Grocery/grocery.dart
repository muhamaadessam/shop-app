import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/Cart/cart_controller.dart';
import 'package:untitled/Favorite/favorite_controller.dart';

import '../models/address_model.dart';
import '../models/cart_model.dart';
import '../models/deals_model.dart';
import '../models/products_model.dart';


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
            future: loadData('assets/data/add.json', AddressModel()),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                var listAddress = snapshot.data;
                // print(listAddress);
                return Container(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                    minHeight: 50,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: listAddress!.addresses!.length,
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
                                      '${listAddress.addresses![index].address}',
                                    ),
                                    SizedBox(
                                      width: 96,
                                      child: Text(
                                        '${listAddress.addresses![index].details}',
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
              }
            },
          ),
          FutureBuilder(
            future:loadData('assets/data/products.json',ProductsModel()),

            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if (snapshot.hasData) {
                var showData = snapshot.data;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Explore by Category'),
                      Text(
                        'See All (${showData.categories.length})',
                        style: const TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          FutureBuilder(
            future:loadData('assets/data/products.json',ProductsModel()),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                var showData = snapshot.data;
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
                          Text('${showData.categories[index].category}'),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 0,
                    ),
                    itemCount: showData.categories.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Deals of the day'),
          ),
          FutureBuilder(
            future: loadData('assets/data/deals.json',DealsModel()),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                var showData = snapshot.data;
                return Container(
                  constraints: const BoxConstraints(
                    maxHeight: 110,
                    minHeight: 50,
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var dealsItem = Deals(
                        id: showData.deals[index].id,
                        title: showData.deals[index].title,
                        price: showData.deals[index].price,
                        description: showData.deals[index].description,
                        oldPrice: showData.deals[index].oldPrice,
                        time: showData.deals[index].time,
                        category:  showData.deals[index].title,
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
                                          var productUpdate = favController
                                              .favList
                                              .firstWhere((element) =>
                                                  element.id ==
                                                      showData.deals[index].id);

                                          favController.favList
                                              .remove(productUpdate);
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
                              Text('${showData.deals[index].title}'),
                              Text(
                                  '${showData.deals[index].description}'),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_outlined),
                                  Text(
                                      '${showData.deals[index].time} Away'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$ ${showData.deals[index].price}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '\$ ${showData.deals[index].oldPrice}',
                                    style: const TextStyle(decoration: TextDecoration.lineThrough,),
                                  ),
                                  const SizedBox(
                                    width: 32,
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        var cartItem = CartModel(
                                          quantity: 1,
                                          id: showData.deals[index].id,
                                          title: showData.deals[index].title,
                                          price: showData.deals[index].price,
                                          category: showData.deals[index].title,
                                        );
                                        if (isExistsInCart(
                                            controller.cart, cartItem)) {
                                          var productUpdate = controller.cart
                                              .firstWhere((element) =>
                                                  element.id ==
                                                      showData.deals[index].id);
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
                    itemCount: showData.deals.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
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

  Future<dynamic> loadData(String source, dynamic model) async {
    String jsonString = await rootBundle.loadString(source);
    var parsedJson = jsonDecode(jsonString);

    if (model is AddressModel) {
      AddressModel modelData = AddressModel.fromJson(parsedJson);
      return modelData;
    }else if (model is ProductsModel) {
      ProductsModel modelData = ProductsModel.fromJson(parsedJson);
      return modelData;
    }else if (model is DealsModel) {
      DealsModel modelData = DealsModel.fromJson(parsedJson);
      return modelData;
    }else{
      CartModel modelData = CartModel.fromJson(parsedJson);
      return modelData;
    }
  }

  Future<dynamic> loadDataProducts(String source) async {
    String jsonString = await rootBundle.loadString(source);
    var parsedJson = jsonDecode(jsonString);
      ProductsModel modelData = ProductsModel.fromJson(parsedJson);
      return modelData;

  }
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
