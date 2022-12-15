import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/Favorite/favorite_controller.dart';

import '../Cart/cart_controller.dart';
import '../model/cart_model.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  final controller = Get.put(CartController());
  final favController = Get.put(FavoriteController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
            height: 16,
          ),
          FutureBuilder(
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                var showData = json.decode(snapshot.data!);
                return Expanded(
                  child: Obx(
                    () => ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (favController.favList.isNotEmpty) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                          child: IconButton(
                                              onPressed: () async {
                                                favController.favList.remove(
                                                    favController
                                                        .favList[index]);
                                                var jsonDBEncoded = jsonEncode(
                                                    favController.favList);
                                                await box.write(
                                                    'Fav', jsonDBEncoded);
                                                controller.cart.refresh();
                                              },
                                              icon: const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 15,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${favController.favList[index].title}'),
                                          Text(
                                              '${favController.favList[index].description}'),
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.location_on_outlined),
                                              Text(
                                                  '${favController.favList[index].time} Away'),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '\$ ${favController.favList[index].price}',
                                                    style: const TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    '\$ ${favController.favList[index].oldPrice}',
                                                    style: const TextStyle(),
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                  onPressed: () async {
                                                    var cartItem = CartModel(
                                                      quantity: 1,
                                                      id: showData['deals']
                                                          [index]['id'],
                                                      title: showData['deals']
                                                          [index]['title'],
                                                      price: showData['deals']
                                                          [index]['price'],
                                                      category:
                                                          showData['deals']
                                                                  [index]
                                                              ['category'],
                                                    );
                                                    if (isExistsInCart(
                                                        controller.cart,
                                                        cartItem)) {
                                                      var productUpdate = controller
                                                          .cart
                                                          .firstWhere((element) =>
                                                              element.id ==
                                                              showData['deals']
                                                                      [index]
                                                                  ['id']);
                                                      productUpdate.quantity++ ;
                                                    } else {
                                                      controller.cart
                                                          .add(cartItem);
                                                    }
                                                    var jsonDBEncoded =
                                                        jsonEncode(
                                                            controller.cart);
                                                    await box.write(
                                                        'Cart', jsonDBEncoded);
                                                    controller.cart.refresh();
                                                  },
                                                  icon: const Icon(
                                                      Icons.add_shopping_cart))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      itemCount: favController.favList.length,
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('x');
              } else {
                return const CircularProgressIndicator();
              }
            },
            future: DefaultAssetBundle.of(context)
                .loadString('assets/data/deals.json'),
          ),
        ],
      ),
    );
  }

  bool isExistsInCart(RxList<CartModel> cart, CartModel cartItem) {
    // return cart.contains(cartItem);
    return cart.isEmpty
        ? false
        : cart.any((element) => element.id == cartItem.id)
            ? true
            : false;
  }
}
