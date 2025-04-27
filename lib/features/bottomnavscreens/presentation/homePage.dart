import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsphere/core/cubit/appCubit/appCubit.dart';

import '../../../core/cubit/appStates/appStates.dart';
import '../../../core/theme/colors.dart';
import '../../user_setting/presentaion/userdata2.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, AppStates state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.index1]),
            actions: cubit.index1 != 3
                ? []
                : [
                    TextButton(
                        onPressed: () {
                          cubit.CangeIndex(0);
                        },
                        child: Text("Back To Home"))
                  ],
          ),
          body: cubit.Screens[cubit.index1],
          floatingActionButton: cubit.index1 == 3
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                  },
                  child: Icon(Icons.account_circle),
                  //params
                ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: cubit.index1 == 3
              ? null
              : AnimatedBottomNavigationBar(
                  blurEffect: true,
                  borderColor: maincolor,
                  splashColor: maincolor,
                  activeColor: maincolor,

                  icons: [
                    Icons.home,
                    Icons.menu,
                    Icons.favorite,
                    Icons.shopping_cart,
                  ],
                  activeIndex: cubit.index1,
                  gapLocation: GapLocation.center,
                  notchSmoothness: NotchSmoothness.verySmoothEdge,
                  leftCornerRadius: 32,
                  rightCornerRadius: 32,

                  onTap: (index) {
                    cubit.CangeIndex(index);
                  },
                  //other params
                ),
          );
      },
      listener: (BuildContext context, AppStates state) {},
    );
  }
}
