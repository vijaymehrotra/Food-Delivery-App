import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/controller/cart_controller.dart';
import 'package:food_delivery/models/cart_models.dart';
import 'package:food_delivery/routes/routes_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, int> cartItemsPerOrder = Map();

    var getCartHistoryList = Get.find<CartController>().getCartHistoryList();
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;
    return Scaffold(
      body: Column(children: [
        Container(
          color: AppColors.mainColor,
          width: double.maxFinite,
          height: 100,
          padding: EdgeInsets.only(top: 45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(text: "Cart History", color: Colors.white),
              AppIcon(
                icon: Icons.shopping_cart_outlined,
                iconColor: AppColors.mainColor,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(Dimensions.height20),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                children: [
                  for (int i = 0; i < itemsPerOrder.length; i++)
                    Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (() {
                            DateFormat("yyyy-MM-dd HH:mm:ss");
                            var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                            //var oututDate = outputFormat.format(date);
                            return Text(getCartHistoryList[listCounter].time!);
                          }()),
                          SizedBox(height: Dimensions.height10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(
                                    itemsPerOrder[i],
                                    (index) {
                                      if (listCounter <
                                          getCartHistoryList.length) {
                                        listCounter++;
                                      }
                                      return index <= 2
                                          ? Container(
                                              height: 80,
                                              width: 80,
                                              margin: EdgeInsets.only(
                                                  right:
                                                      Dimensions.height10 / 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.height15 /
                                                              2),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppConstant.BASE_URL +
                                                              AppConstant
                                                                  .UPLOAD_URL +
                                                              getCartHistoryList[
                                                                      listCounter -
                                                                          1]
                                                                  .img!))),
                                            )
                                          : Container();
                                    },
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SmallText(
                                          text: "Total",
                                          color: AppColors.titleColor),
                                      BigText(
                                          text: itemsPerOrder[i].toString() +
                                              " Items",
                                          color: AppColors.titleColor),
                                      GestureDetector(
                                        onTap: () {
                                          var orderTime = cartOrderTimeToList();
                                          Map<int, CartModel> moreOrder = {};
                                          for (int j = 0;
                                              j < getCartHistoryList.length;
                                              j++) {
                                            if (getCartHistoryList[j].time ==
                                                orderTime[i]) {
                                              // print("The cart or product id is : " +
                                              //     getCartHistoryList[j].id.toString());

                                              moreOrder.putIfAbsent(
                                                  getCartHistoryList[j].id!,
                                                  () => CartModel.fromJson(
                                                      jsonDecode(jsonEncode(
                                                          getCartHistoryList[
                                                              j]))));
                                            }
                                          }
                                          Get.find<CartController>().setItems =
                                              moreOrder;
                                          Get.find<CartController>()
                                              .addToCartList();
                                          Get.toNamed(
                                              RoutesHelper.getCartPage()); 
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: Dimensions.height10 / 2,
                                              horizontal: Dimensions.height10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20 / 4),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.mainColor)),
                                          child: SmallText(
                                            text: "one more",
                                            color: AppColors.mainColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ]),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
