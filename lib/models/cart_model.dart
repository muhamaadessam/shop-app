import 'deals_model.dart';
import 'products_model.dart';

class CartModel extends Deals {
  int quantity = 1;

  CartModel({required this.quantity, id, title, category, price, description})
      : super(
          id: id,
          title: title,
          category: category,
          description: description,
          price: price,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final product = Products.fromJson(json);
    final quantity = json['quantity'];
    return CartModel(
        quantity: quantity,
        title: product.title,
        description: product.description,
        id: product.id,
        category: product.category,
        price: product.price);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = this.title;
    data['id'] = this.id;
    data['description'] = this.description;
    data['price'] = this.price;
    data['oldPrice'] = this.oldPrice;
    return data;
  }
}
