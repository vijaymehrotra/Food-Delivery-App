import 'package:dots_indicator/dots_indicator.dart';
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
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
        print("Current value is: " + _currPageValue.toString());
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 320,
          child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItems(position);
              }),
        ),
        
        new DotsIndicator(
          dotsCount: 5,
          position: _currPageValue.toInt(),
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        )
      ],
    );
  }

  Widget _buildPageItems(int index) {
    Matrix4 matrix = new Matrix4.identity();

    if (index == _currPageValue.floor()) {
      var currscale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currscale) / 2;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currscale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currscale) / 2;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currscale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currscale) / 2;
      matrix = Matrix4.diagonal3Values(1, currscale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - currScale) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
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
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                ]),
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
      ]),
    );
  }
}
