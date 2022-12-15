import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/Cart/cart_controller.dart';
import 'package:untitled/Favorite/favorite.dart';
import 'package:untitled/Favorite/favorite_controller.dart';
import 'package:untitled/Grocery/grocery.dart';
import 'package:untitled/Home/home_controller.dart';

import '../Cart/Cart.dart';
import '../models/cart_model.dart';
import '../models/deals_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeController());
  final cartController = Get.put(CartController());
  final favController = Get.put(FavoriteController());
  final box = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String cartSave = await box.read('Cart');
      String favSave = await box.read('Fav');
      if (cartSave.isNotEmpty && cartSave.isNotEmpty) {
        final listCart = jsonDecode(cartSave) as List<dynamic>;
        final listCartParsed =
            listCart.map((e) => CartModel.fromJson(e)).toList();
        if (listCartParsed.isNotEmpty)
          cartController.cart.value = listCartParsed;
      }
      if (favSave.isNotEmpty && favSave.isNotEmpty) {
        final listCart = jsonDecode(favSave) as List<dynamic>;
        final listCartParsed = listCart.map((e) => Deals.fromJson(e)).toList();
        if (listCartParsed.isNotEmpty)
          favController.favList.value = listCartParsed;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return SafeArea(
      child: GetBuilder<HomeController>(
        builder: (context) => Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Obx(
            () => FloatingActionButton(
              onPressed: () {},
              child: Text(
                '\$${cartController.sumCart()}',
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex,
            onTap: controller.changeTabIndex,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Grocery',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_none,
                ),
                label: 'News',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.ice_skating,
                  color: Colors.transparent,
                  size: 0,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border,
                ),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.door_front_door_outlined,
                ),
                label: 'Cart',
              ),
            ],
          ),
          body: IndexedStack(
            index: controller.tabIndex,
            children: [
              GroceryScreen(),
              const Center(
                  child: Text(
                'News',
                style: TextStyle(fontSize: 24),
              )),
              Container(),
              FavoriteScreen(),
              CartScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
