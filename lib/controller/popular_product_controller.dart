import 'package:flutter/material.dart';
import 'package:food_delivery/data/api/repository.dart/popular_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/home/food/recommended_food_detail.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

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
      if (_quantity < 20) {
        _quantity = _quantity + 1;
      } else {
        Get.snackbar("Item Count", "Maximum Limit Reached",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    } else {
      if (_quantity > 0) {
        _quantity = _quantity - 1;
      } else
        Get.snackbar("Item Count", "You cant reduce more",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
    update();
  }

  void initProduct() {
    _quantity = 0;
    _inCartItems = 0;
  }
}
