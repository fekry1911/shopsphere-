import 'package:banner_carousel/banner_carousel.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/cupertino.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopsphere/core/cubit/appCubit/appCubit.dart';
import 'package:shopsphere/core/models/homeModel.dart';
import 'package:shopsphere/core/states/appStates/appStates.dart';
import 'package:shopsphere/features/reuse/gridview.dart';

import '../../theme/colors.dart';
import '../prodect_details.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homemodel1 != homeModel() && cubit.favdata.isNotEmpty && cubit.homemodel1!.data != null ,
          fallback: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          builder: (BuildContext context) {
            return ListView(
              children: [
                FanCarouselImageSlider.sliderType1(
                  imagesLink: [
                    cubit.homemodel1!.data!.banners![0].image!,
                    cubit.homemodel1!.data!.banners![1].image!,
                    cubit.homemodel1!.data!.banners![2].image!
                  ],
                  imageFitMode: BoxFit.fill,
                  isAssets: false,
                  autoPlay: true,
                  sliderWidth: double.infinity,
                  sliderHeight: 200,
                  showIndicator: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 0, // Space between columns
                      mainAxisSpacing: 0, // Space between rows
                      childAspectRatio:
                          .6, // Adjust for item height/width ratio
                    ),
                    itemCount: cubit.homemodel1!.data!.products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProdectDetails()));

                          cubit.GetProdectDetails(
                                  cubit.homemodel1!.data!.products![index].id!)
                              .then((onValue) {
                            print(
                                cubit.homemodel1!.data!.products![index].name);
                          });
                        },
                        child: CardCustom(
                          model: cubit.homemodel1!.data!.products![index],
                          ontab: () {
                            cubit.AddOrRemoveToFav(context: context,
                                id: cubit
                                    .homemodel1!.data!.products![index].id!);
                            cubit.GetHomeData();
                          }, FacCheck: cubit.favdata[cubit.homemodel1!.data!.products![index].id!]!,
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          },
        );
      },
      listener: (BuildContext context, AppStates state) {},
    );
  }
}
