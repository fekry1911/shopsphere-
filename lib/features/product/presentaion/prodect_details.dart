import 'package:banner_carousel/banner_carousel.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_carousel_slider/image_carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopsphere/core/cubit/appCubit/appCubit.dart';
import 'package:shopsphere/features/product/data/models/prodectmodel.dart';

import '../../../core/cubit/appStates/appStates.dart';
import '../../../core/theme/colors.dart';


class ProdectDetails extends StatelessWidget {
  const ProdectDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, AppStates state) {
          var cubit = AppCubit.get(context);
          return LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth >
                  600; // تحديد هل الشاشة كبيرة (تابلت/ويب)
              double padding =
                  isWide ? 32.0 : 16.0; // تقليل الهوامش على الشاشات الصغيرة

              return ConditionalBuilder(
                condition: cubit.prodect != ProdectDetilsModel() && cubit.prodect.data != null,
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                    title:
                    Text(cubit.prodect.data!.name!, style: GoogleFonts.tajawal()),
                    actions: [
                      IconButton(
                        icon: cubit.favdata[cubit.prodect.data!.id!]!
                            ? Icon(
                                Icons.favorite,
                                color: maincolor,
                              )
                            : Icon(
                                Icons.favorite_border,
                              ),
                        onPressed: () {
                          cubit.AddOrRemoveToFav(id: cubit.prodect.data!.id!,context: context)
                              .then((onValue) {
                                cubit.GetProdectDetails(cubit.prodect.data!.id!);

                          });
                          print(cubit.prodect.data!.inFavorites);

                          cubit.GetProdectDetails(cubit.prodect.data!.id!);
                        },
                      ),
                    ],
                  ),
                    body: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: padding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                /// 🔥 **Image Slider**
                                Center(
                                  child: Container(
                                    width: isWide ? 500 : double.infinity,
                                    // تقليل العرض في الشاشات الكبيرة
                                    child: cubit.prodect.data!.images != null &&
                                        cubit.prodect.data!.images!.isNotEmpty
                                        ? FanCarouselImageSlider.sliderType2(
                                      imagesLink: cubit.prodect.data!.images!,
                                      isAssets: false,
                                      imageFitMode: BoxFit.contain,
                                      autoPlay: false,
                                      sliderHeight: 300,
                                      sliderDuration: const Duration(milliseconds: 200),
                                      imageRadius: 0,
                                      slideViewportFraction: 1.2,
                                    )
                                        : SizedBox(),
                                    // ✅ تجنب عرض مكون فارغ يسبب مشاكل في Sliver
                                  ),
                                ),
                                SizedBox(height: 20),

                                /// 🏷️ **Product Name**
                                Text(
                                  cubit.prodect.data!.name!,
                                  style: GoogleFonts.tajawal(
                                      fontSize: isWide ? 26 : 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),

                                /// 💰 **Price & Discount**
                                Row(
                                  children: [
                                    Text(
                                      "${cubit.prodect.data!.price!} جنيه",
                                      style: TextStyle(
                                          fontSize: isWide ? 22 : 18,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10),
                                    if (cubit.prodect.data!.discount! > 0)
                                      Text(
                                        "${cubit.prodect.data!.oldPrice!} جنيه",
                                        style: TextStyle(
                                          fontSize: isWide ? 20 : 16,
                                          color: Colors.red,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 10),

                                /// 📝 **Description**
                                GestureDetector(
                                  onTap: () {
                                    cubit.expandtext();
                                  },
                                  child: Text(
                                    cubit.prodect.data!.description!,
                                    style: GoogleFonts.tajawal(
                                        fontSize: isWide ? 18 : 16,
                                        color: Colors.grey[700]),
                                    maxLines: cubit.max ? 200 : 8,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 20),

                                /// 🛒 **Add to Cart Button**
                                Center(
                                  child: SizedBox(
                                    width: isWide ? 400 : double.infinity,
                                    // تقليل العرض في الشاشات الكبيرة
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize:
                                        Size(double.infinity, isWide ? 60 : 50),
                                      ),
                                      icon: Icon(Icons.shopping_cart),
                                      label:state is GetDataHProdectLoadState?Center(child: CircularProgressIndicator(),): cubit.cartdata[cubit.prodect.data!.id!]!?Text("remove from your cart"):Text("add to your cart"),
                                      onPressed: () {
                                        cubit.AddOrRemoveToCart(id: cubit.prodect.data!.id!, context: context).then((onValue){
                                          print(cubit.prodect.data!.inCart!);
                                          cubit.GetProdectDetails(cubit.prodect.data!.id!);

                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        )
                  );
                },
                fallback: (BuildContext context) {
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator(),),
                  );
                },
              );
            },
          );
        },
        listener: (BuildContext context, AppStates state) {});
  }
}
