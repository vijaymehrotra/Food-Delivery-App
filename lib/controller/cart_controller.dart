import 'package:food_delivery/data/api/repository.dart/cart_repo.dart';
import 'package:food_delivery/models/cart_models.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  void addItem(ProductModel product , int quantity){
    _items.putIfAbsent(product.id! , () => null)
  }
}
