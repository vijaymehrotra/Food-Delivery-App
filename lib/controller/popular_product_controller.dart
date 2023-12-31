import 'package:flutter/material.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/data/repository.dart/popular_product_repo.dart';
import 'package:food_delivery/models/cart_models.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/food/recommended_food_detail.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int getQuantity() => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool plus) {
    if (plus) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
      // print("decrement : " + _quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item Count", "You can,t reduce more!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return quantity + 1;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar("Item Count", "You can,t add more!",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return quantity - 1;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;

    var exist = false;
    exist = _cart.existInCart(product);

    // print("exist or not :" +  exist.toString());

    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    // print("The quantity in the cart is : " + _inCartItems.toString());
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print("The id id: " +
          value.id.toString() +
          " The quantity is " +
          value.quantity.toString());
    });
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
