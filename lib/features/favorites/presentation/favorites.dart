import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsphere/core/cubit/appCubit/appCubit.dart';
import '../../../core/component_widget/reuse/gridview.dart';
import '../../../core/cubit/appStates/appStates.dart';
import '../../product/presentaion/prodect_details.dart';
import '../data/models/favoritesmodel.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, AppStates state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.favoritesModel != FavoritesModel() && cubit.favoritesModel?.data !=null,
          fallback: (BuildContext context) {
            return Center(child: Text("No item in Favorites"),);
          },
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 0, // Space between columns
                  mainAxisSpacing: 0, // Space between rows
                  childAspectRatio: .6, // Adjust for item height/width ratio
                ),
                itemCount: cubit.favoritesModel!.data!.data2!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      cubit.GetProdectDetails(cubit.favoritesModel!.data!.data2![index].product!.id!).then((onValue){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProdectDetails()));
                      });
                    },
                    child: CardCustom(model: cubit.favoritesModel!.data!.data2![index].product!,ontab:(){
                      cubit.AddOrRemoveToFav(context: context,id: cubit.favoritesModel!.data!.data2![index].product!.id!);

                    }, FacCheck: true,),
                  );
                },
              ),
            );
          },);
      },
      listener: (BuildContext context, AppStates state) {},
    );
  }
}
