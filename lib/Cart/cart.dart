import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/Cart/cart_controller.dart';

class CartScreen extends GetView<CartController> {
  CartScreen({super.key});

  final box = GetStorage();
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Cart',
              style: TextStyle(fontSize: 15),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartController.cart[index].title!,
                          style: const TextStyle(
                            color: Color.fromARGB(225, 43, 61, 81),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          cartController.cart[index].title!,
                          style:
                              const TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                        Text(
                          '\$ ${cartController.cart[index].price}',
                          style: const TextStyle(
                              color: Color.fromARGB(225, 177, 62, 85),
                              fontSize: 18),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        cartController.cart[index].quantity++;
                        var jsonDBEncoded = jsonEncode(controller.cart);
                        await box.write('Cart', jsonDBEncoded);
                        controller.cart.refresh();
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        cartController.cart[index].quantity.toString(),
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (cartController.cart[index].quantity > 1) {
                          cartController.cart[index].quantity--;
                        }
                        var jsonDBEncoded = jsonEncode(controller.cart);
                        await box.write('Cart', jsonDBEncoded);
                        controller.cart.refresh();
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.remove, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 8,
              ),
              itemCount: cartController.cart.length,
              physics: const BouncingScrollPhysics(),
            ),
          )
        ],
      ),
    );
  }
}
