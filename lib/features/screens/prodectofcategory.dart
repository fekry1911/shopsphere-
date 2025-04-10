import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsphere/core/cubit/appCubit/appCubit.dart';
import 'package:shopsphere/core/models/categoriesprodects.dart';
import 'package:shopsphere/core/states/appStates/appStates.dart';
import 'package:shopsphere/features/screens/prodect_details.dart';

import '../reuse/gridView.dart';

class ProdectsofCateg extends StatelessWidget {
  const ProdectsofCateg({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, AppStates state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: cubit.categoriesModel != ProdectsInCategoriesModel() && cubit.categoriesModel.data != null,
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
                  itemCount: cubit.categoriesModel.data!.data!.length!,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProdectDetails()));
                        cubit.GetProdectDetails(cubit.categoriesModel.data!.data![index].id!).then((onValue){
                        });
                      },
                      child: CardCustom(model: cubit.categoriesModel.data!.data![index],ontab:(){
                        cubit.AddOrRemoveToFav(id: cubit.categoriesModel.data!.data![index].id!,context: context);
                      }, FacCheck: cubit.favdata[cubit.categoriesModel.data!.data![index].id]!,),
                    );
                  },
                ),
              );
            },
            fallback: (BuildContext context) {
              return Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
      listener: (BuildContext context, AppStates state) {},
    );
  }
}
