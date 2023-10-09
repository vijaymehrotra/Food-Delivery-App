import 'dart:convert';

import 'package:food_delivery/models/cart_models.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];
  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstant.CART_LIST);
    // sharedPreferences.remove(AppConstant.CART_HISTORY);
    var time = DateTime.now().toString();
    cart = [];
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstant.CART_LIST, cart);
    // print(sharedPreferences.getStringList(AppConstant.CART_LIST));
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstant.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstant.CART_LIST)!;
      print("inside getCartList " + carts.toString());
    }
    List<CartModel> cartList = [];

    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstant.CART_HISTORY)) {
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstant.CART_HISTORY)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void aadToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstant.CART_HISTORY)) {
      cartHistory = sharedPreferences.getStringList(AppConstant.CART_HISTORY)!;
    }

    for (int i = 0; i < cart.length; i++) {
      // print("History List " + cart[i].toString());

      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstant.CART_HISTORY, cartHistory);
    print("the length of history list is " +
        getCartHistoryList().length.toString());
    for (int j = 0; j < getCartHistoryList().length; j++) {
      print("The time for the order is " +
          getCartHistoryList()[j].time.toString());
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstant.CART_LIST);
  }
}
