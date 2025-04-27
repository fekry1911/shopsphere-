import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class SliderImages extends StatelessWidget {
   SliderImages({super.key,required images});
   var images;

  @override
  Widget build(BuildContext context) {
    return BannerCarousel(
      banners: images
          ?.map(
            (e) => BannerModel(
          imagePath: e,
          id: '',
        ),
      )
          .toList(),
      customizedIndicators: IndicatorModel.animation(
        width: 40,
        height: 10,
        spaceBetween: 1,
        widthAnimation: 50,
      ),
      height: MediaQuery.of(context).size.height * .2,
      activeColor: maincolor,
      disableColor: Colors.white,
      animation: true,
      borderRadius: 10,
      width: double.infinity,
      indicatorBottom: false,
    );
  }
}
