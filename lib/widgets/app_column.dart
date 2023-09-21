import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BigText(text: text,size: Dimensions.font26,),
      SizedBox(height: Dimensions.height10),
      Row(
        children: [
          Wrap(
            children: List.generate(
              5,
              (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15),
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
      SizedBox(height: Dimensions.height20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    ]);
  }
}
