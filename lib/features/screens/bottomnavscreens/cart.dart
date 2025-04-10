import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopsphere/core/models/cartmodel1.dart';
import 'package:shopsphere/features/reuse/cartcard.dart';
import 'package:shopsphere/features/theme/colors.dart';

import '../../../core/cubit/appCubit/appCubit.dart';
import '../../../core/states/appStates/appStates.dart';
import '../payment/choose.dart';
import '../payment/payment.dart';
import '../prodectofcategory.dart';
import '../user/adresses/BOTTOMSHEET.dart';
import '../user/adresses/addaddress.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        var cubit = AppCubit.get(context);
        return Column(
          children: [
            Expanded(
              child: ConditionalBuilder(
                condition: cubit.cartmodel1 != cartmodel() &&
                    cubit.cartmodel1.data != null,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            var cartItem =
                                cubit.cartmodel1.data!.cartItems![index];
                            return state is AddOrRemoveToCartloadState
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    direction: ShimmerDirection.ltr,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: 100.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        child: Cartcard(
                                          key: ValueKey(cartItem.id),
                                          // Adding a unique key for each cart item
                                          model: cubit.cartmodel1.data!
                                              .cartItems![index],
                                          ontab: () {
                                            int? count;
                                            if (cubit
                                                    .cartmodel1
                                                    .data!
                                                    .cartItems![index]
                                                    .quantity !=
                                                1) {
                                               count = cubit
                                                  .cartmodel1
                                                  .data!
                                                  .cartItems![index]
                                                  .quantity;
                                              count = count! - 1;
                                              cubit
                                                  .cartmodel1
                                                  .data!
                                                  .cartItems![index]
                                                  .quantity = count;
                                              cubit.UpdateCart(
                                                  id: cubit.cartmodel1.data!
                                                      .cartItems![index].id!,
                                                  quantity: count);
                                            }
                                          },
                                          ontab1: () {
                                            int? count;

                                            count = cubit.cartmodel1.data!
                                                .cartItems![index].quantity;
                                            count = count! + 1;
                                            cubit
                                                .cartmodel1
                                                .data!
                                                .cartItems![index]
                                                .quantity = count;
                                            cubit.UpdateCart(
                                                id: cubit.cartmodel1.data!
                                                    .cartItems![index].id!,
                                                quantity: count);
                                          },
                                          ontab2: () {
                                            cubit.DeleteCart(
                                                id: cubit.cartmodel1.data!
                                                    .cartItems![index].id!);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                          itemCount: cubit.cartmodel1.data!.cartItems!.length,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Price Details (${cubit.cartmodel1.data!.cartItems!.length})",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RowOfCartTotal(
                                  title: "Total Price",
                                  amount: cubit.cartmodel1.data!.total,
                                ),
                                RowOfCartTotal(
                                  title: "Discount",
                                  amount: 0,
                                ),
                                RowOfCartTotal(
                                  title: "Delivery Fee",
                                  amount: 50,
                                ),
                                Divider(
                                  thickness: 2,
                                  endIndent: 20,
                                  indent: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                RowOfCartTotal(
                                    title: "Total Amount",
                                    amount: cubit.cartmodel1.data!.total! + 50,
                                    color: maincolor,
                                    size: 20.0,
                                    weight: FontWeight.bold,
                                    color1: Colors.black),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                fallback: (BuildContext context) {
                  return Center(
                    child: Text("your cart is empty"),
                  );
                },
              ),
            ),
            if (cubit.cartmodel1 == cartmodel()) Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.2),
                border: Border.all(
                  color: maincolor, // Set the border color here
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      state is AddOrRemoveToCartloadState
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "${cubit.cartmodel1.data!.total!} جنيه",
                              style: TextStyle(
                                color: maincolor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add navigation to checkout screen


                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) => BlocProvider.value(
                          value: context.read<AppCubit>(),
                          child: AddressBottomSheet(
                            onAddNewAddress: () {
                              // TODO: Navigate to add address screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddAddressScreen(),
                                  ));
                            },
                            onContinue: () {
                              // TODO: Handle continue
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethodScreen()));
                            }, selectedAddressType: '', onAddressSelected: (String ) {  },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: state is initiatePaymentload
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text("Continue"),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

Widget RowOfCartTotal({
  required amount,
  required title,
  color,
  weight,
  size,
  color1,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    child: Row(
      children: [
        Text(
          "$title",
          style: TextStyle(color: color1, fontSize: size, fontWeight: weight),
        ),
        Spacer(),
        Text(
          "$amount EGP",
          style: TextStyle(color: color, fontSize: size, fontWeight: weight),
        ),
      ],
    ),
  );
}
