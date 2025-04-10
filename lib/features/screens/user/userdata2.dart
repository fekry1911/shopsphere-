import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shopsphere/core/cubit/logincubit/loginCubit.dart';
import 'package:shopsphere/core/states/loginstate/loginStates.dart';
import 'package:shopsphere/features/screens/auth/login.dart';
import 'package:shopsphere/features/screens/user/settings/langchange.dart';
import 'package:shopsphere/features/screens/user/updateuser.dart';

import '../../reuse/buildActionItem.dart';
import 'adresses/adresses.dart';

class ProfileScreen extends StatelessWidget {
  final Color lightBlue = Color(0xffe6f4f1);
  final Color lightRed = Color(0xffffe6e6);
  final Color lightGrey = Color(0xfff2f4f6);
  final List<SettingItem> items = [
    SettingItem(
        icon: Icons.credit_card, title: "My Payment", color: Colors.purple),
    SettingItem(
        icon: Icons.location_on, title: "My Address", color: Colors.red),
    SettingItem(icon: Icons.language, title: "Language", color: Colors.blue),
    SettingItem(icon: Icons.dark_mode, title: "Mode", color: Colors.indigo),
    SettingItem(
        icon: Icons.support_agent, title: "Support", color: Colors.deepPurple),
    SettingItem(
        icon: Icons.article, title: "Terms & Conditions", color: Colors.brown),
    SettingItem(
        icon: Icons.logout, title: "Logout", color: Colors.red, isLogout: true),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double profileImageSize = screenWidth * 0.18;
    double iconSize = screenWidth * 0.07;

    return Scaffold(
      //  backgroundColor:Colors.white,
      appBar: AppBar(
        //backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text("Profile", style: TextStyle(color: Colors.black)),
        centerTitle: false,
      ),
      body: BlocConsumer<LoginCubit, LoginSates>(
        builder: (BuildContext context, state) {
          var cubit = LoginCubit.get(context);
          return ConditionalBuilder(
            condition: state is! GetProfileloadState,
            builder: (BuildContext context) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Stack(
                            clipBehavior: Clip.none, // <--- allow overflow
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: profileImageSize,
                                backgroundImage: NetworkImage(
                                    cubit.usermodel1.data!.image!),
                              ),
                              Positioned(
                                top: 55,
                                left: 110,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.black,
                                    child: Icon(Icons.camera_alt,
                                        size: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      cubit.usermodel1.data!.name!,
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.045,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                      cubit.usermodel1.data!.phone!
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.1,
                                          vertical: 12),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateUserScreen()));
                                    },
                                    child: Text("Edit Profile",
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Spacer(),
                                    buildActionItem(
                                      icon: Icons.shopping_cart_outlined,
                                      label: "My Cart",
                                      bgColor: lightGrey,
                                      iconSize: iconSize,
                                    ),
                                    Spacer(),
                                    buildActionItem(
                                      icon: Icons.favorite,
                                      label: "My Favourite",
                                      bgColor: lightRed,
                                      iconColor: Colors.red,
                                      iconSize: iconSize,
                                    ),
                                    Spacer(),
                                    buildActionItem(
                                      icon: Icons.mail_outline,
                                      label: "My Orders",
                                      bgColor: lightBlue,
                                      iconSize: iconSize,
                                      overlayIcon: CircleAvatar(
                                        radius: 8,
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.check_circle,
                                            color: Colors.green, size: 14),
                                      ),
                                    ),
                                    Spacer(),
                                    buildActionItem(
                                      icon: Icons.mail_outline,
                                      label: "Received",
                                      bgColor: lightGrey,
                                      iconSize: iconSize,
                                      overlayIcon: CircleAvatar(
                                        radius: 8,
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.check_circle,
                                            color: Colors.green, size: 14),
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                Divider(
                                    thickness: 1,
                                    color: Colors.grey.shade300,
                                    indent: 20,
                                    endIndent: 20),
                                ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  itemCount: items.length,
                                  separatorBuilder: (_, index) {
                                    if (index == items.length - 2) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Divider(
                                            thickness: 1,
                                            color: Colors.grey.shade300,
                                            indent: 20,
                                            endIndent: 20),
                                      );
                                    }
                                    return SizedBox(height: 8);
                                  },
                                  itemBuilder: (context, index) {
                                    final item = items[index];
                                    return ListTile(
                                      onTap:(){
                                        if(item.title=="Language"){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeLanguageScreen()));
                                        }
                                        if(item.title=="My Address"){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressScreen()));
                                        }
                                        if(item.title=="Logout"){
                                          cubit.LogOut().then((onValue){
                                            Phoenix.rebirth(context);
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                                          });
                                        }
                                      },
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            item.color.withOpacity(0.1),
                                        child: Icon(item.icon,
                                            color: item.color),
                                      ),
                                      title: Text(
                                        item.title,
                                        style: TextStyle(
                                          color: item.isLogout
                                              ? Colors.red
                                              : Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios,
                                          size: 16, color: Colors.grey),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
            fallback: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}

class SettingItem {
  final IconData icon;
  final String title;
  final Color color;
  final bool isLogout;

  SettingItem({
    required this.icon,
    required this.title,
    required this.color,
    this.isLogout = false,
  });
}
