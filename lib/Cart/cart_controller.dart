import 'package:get/get.dart';
import 'package:untitled/model/cart_model.dart';


class CartController extends GetxController {
  var cart = List<CartModel>.empty(growable: true).obs;

  int? sumCart() {
    if(cart.isNotEmpty) {
      return cart
        .map((e) => int.parse(e.price.toString())*e.quantity)
        .reduce((previousValue, element) => previousValue + element);
    }else{
      return 0;
    }
  }

  getQuantity(){
    if(cart.isNotEmpty) {
      return cart
          .map((e) => e.quantity.toString())
          .reduce((previousValue, element) => previousValue + element);
    }else{
      return 0;
    }
  }
}
