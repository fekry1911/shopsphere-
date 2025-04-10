import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsphere/core/cubit/appCubit/appCubit.dart';
import 'package:shopsphere/core/states/appStates/appStates.dart';
import 'package:shopsphere/features/theme/colors.dart';

import '../../../../core/data/api/maps/maps.dart';
import 'addaddress.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('My Addresses'),
      ),
      body: BlocConsumer<AppCubit,AppStates>(
        builder: (BuildContext context, state) {
          var cubit =AppCubit.get(context);
          var adress=cubit.adressmodel.data!.data;
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cubit.adressmodel.data!.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          openMapLocation(lat: adress[index].latitude!, lng: adress[index].longitude!);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(adress![index].name ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.location_city, size: 20, color: Colors.purple),
                                    const SizedBox(width: 8),
                                    Text("${adress![index].city}, ${adress![index].region}"),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.place, size: 20, color: Colors.purple),
                                    const SizedBox(width: 8),
                                    Flexible(child: Text(adress![index].details ?? '')),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.note, size: 20, color: Colors.purple),
                                    const SizedBox(width: 8),
                                    Flexible(child: Text(adress![index].notes ?? '')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
             // Spacer(),
              Container(
                margin: EdgeInsets.all(20),
                height: width*.15,
                width: double.infinity,
                child: ElevatedButton(

                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddressScreen()));
                    }, child: Text("Add New Address")),
              )
            ],
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
