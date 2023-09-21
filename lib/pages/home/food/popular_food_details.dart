import 'package:flutter/material.dart';
import 'package:food_delivery/controller/popular_product_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];

    Get.find<PopularProductController>().initProduct();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  // image: AssetImage("assets/image/food0.png"),
                  image: NetworkImage(AppConstant.BASE_URL +
                      AppConstant.UPLOAD_URL +
                      product.img!),
                )),
              ),
            ),
            Positioned(
              top: Dimensions.height45,
              left: Dimensions.height20,
              right: Dimensions.height20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(MainFoodPage());
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 31,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.height20,
                    right: Dimensions.height20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20)),
                  color: Colors.white,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(text: product.name!),
                      SizedBox(height: Dimensions.height20),
                      BigText(text: "Introduce"),
                      SizedBox(height: Dimensions.height20),
                      Expanded(
                          child: SingleChildScrollView(
                              child: ExpandableTextWidget(
                                  text: product.description!)))
                    ]),
              ),
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProduct) {
            return Container(
              height: Dimensions.pageViewTextContainer,
              padding: EdgeInsets.fromLTRB(
                  Dimensions.height20,
                  Dimensions.height30,
                  Dimensions.height20,
                  Dimensions.height30),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.all(Dimensions.height20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20)),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                popularProduct.setQuantity(false);
                              },
                              child: Icon(Icons.remove,
                                  color: AppColors.signColor)),
                          BigText(
                              text: popularProduct.getQuantity().toString()),
                          GestureDetector(
                              onTap: () {
                                popularProduct.setQuantity(true);
                              },
                              child:
                                  Icon(Icons.add, color: AppColors.signColor)),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.all(Dimensions.height20),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20)),
                      child: Row(
                        children: [
                          BigText(
                            text:
                                "\$ ${product.price! * popularProduct.getQuantity()} | Add to cart",
                            color: Colors.white,
                          ),
                        ],
                      )),
                ],
              ),
            );
          },
        ));
  }
}
