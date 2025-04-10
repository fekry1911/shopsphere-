import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart'
    show BuildContext, StatelessWidget, Widget;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsphere/core/cubit/appCubit/appCubit.dart';
import 'package:shopsphere/core/models/categoriesmodel.dart';
import 'package:shopsphere/core/models/categoriesprodects.dart';
import 'package:shopsphere/core/states/appStates/appStates.dart';

import '../prodectofcategory.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoreModel != CategoreModel() && cubit.categoreModel.data !=null,
          builder: (BuildContext context) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: Hero(
                      tag: cubit.categoreModel.data!.data![index].name!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                            cubit.categoreModel.data!.data![index].image!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover),
                      ),
                    ),
                    title: Text(cubit.categoreModel.data!.data![index].name!,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
                    onTap: () {
                      cubit.categoriesModel=ProdectsInCategoriesModel();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProdectsofCateg()));
                      cubit.GetCategoriesDEtails(
                              cubit.categoreModel.data!.data![index].id!)
                          .then((onValue) {

                      });
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemCount: cubit.categoreModel.data!.data!.length,
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
    );
  }
}
