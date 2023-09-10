import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: PageView.builder(
          controller: pageController,
          itemCount: 5,
          itemBuilder: (context, position) {
            return _buildPageItems(position);
          }),
    );
  }

  Widget _buildPageItems(int index) {
    return Stack(children: [
      Container(
        height: 220,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color(0xFF69c5df),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/image/food0.png"),
            )),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 120,
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(children: [
              BigText(text: "Chinese Side"),
              SizedBox(height: 10),
              Row(
                children: [
                  Wrap(
                    children: List.generate(
                      5,
                      (index) => Icon(Icons.star,
                          color: AppColors.mainColor, size: 15),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SmallText(text: "4.5"),
                  SizedBox(
                    width: 10,
                  ),
                  SmallText(text: "1287 comments")
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  IconAndText(
                    text: "Normal",
                    icon: Icons.circle_sharp,
                    iconColor: AppColors.iconColor1,
                  ),
                  IconAndText(
                    text: "1.7km",
                    icon: Icons.location_on,
                    iconColor: AppColors.mainColor,
                  ),
                  IconAndText(
                    text: "32min",
                    icon: Icons.access_time_rounded,
                    iconColor: AppColors.iconColor2,
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    ]);
  }
}
