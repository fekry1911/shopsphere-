import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsphere/core/cubit/appCubit/appCubit.dart';
import 'package:shopsphere/core/data/local/cache_helper.dart';

import '../../../../core/cubit/appStates/appStates.dart';
import '../../../payment/data/models/paymentmodel.dart';

class AddressBottomSheet extends StatelessWidget {
  final String? selectedAddressType;
  final Function(String) onAddressSelected;
  final VoidCallback onContinue;
  final VoidCallback onAddNewAddress;

  AddressBottomSheet({
    required this.selectedAddressType,
    required this.onAddressSelected,
    required this.onContinue,
    required this.onAddNewAddress,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        var cubit = AppCubit.get(context);
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Address Cards
              ...cubit.adressmodel.data!.data!.map((address) {
                final isSelected = selectedAddressType == address.name;
                return GestureDetector(
                  onTap: () {
                    onAddressSelected(address.name!);


                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                address.name!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(height: 4),
                              Text(
                                address.city!,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 2),
                              Text(
                                address.region!,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                        Radio<int>(
                          value: address.id!,
                          groupValue: cubit.selectedAddressType,
                          onChanged: (value) {cubit.select(value);
                          cubit.details1 = PaymentModel(
                            name: CacheHelper.getData(key: "name") ?? "Abdo Fekry",
                            email: CacheHelper.getData(key: "email") ?? "AbdoFekry@gmail.com",
                            city: address.city!,
                            phone_number: CacheHelper.getData(key: "phone") ?? "+20123456789",
                            street: address.details!,);
                          print(cubit.details1.city);
                          print(cubit.details1.name);
                          print(cubit.details1.street);
                          print(cubit.details1.phone_number);
                          print(cubit.details1.email);

                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),

              // Add New Address
              TextButton(
                onPressed: onAddNewAddress,
                child: Text(
                  '+ Add New Address',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 8),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
      listener: (BuildContext context, state) {},
    );
  }
}
