import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsphere/core/cubit/appCubit/appCubit.dart';

import '../../../../../core/cubit/appStates/appStates.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController location = TextEditingController();

  late double lat;
  late double lon;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Address"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWide ? 600 : double.infinity),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: BlocConsumer<AppCubit, AppStates>(
                builder: (BuildContext context, state) {
                  var cubit = AppCubit.get(context);
                  return ListView(
                    children: [
                      _buildTextField(
                          nameController, "Address Name (e.g., Home, Work)"),
                      const SizedBox(height: 12),
                      _buildTextField(cityController, "City"),
                      const SizedBox(height: 12),
                      _buildTextField(regionController, "Region"),
                      const SizedBox(height: 12),
                      _buildTextField(detailsController,
                          "Details (street, building, etc.)"),
                      const SizedBox(height: 12),
                      _buildTextField(
                          location, " lang and long of your location", isOptional: true,isEnabel: false),
                      const SizedBox(height: 24),
                      _buildTextField(notesController, "Notes (optional)",
                          isOptional: true),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          cubit.getCurrentLocation().then((value) {
                            location.text =
                                "${value.latitude}, ${value.longitude}";
                            lat = value.latitude;
                            lon = value.longitude;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: state is GelLocLoad
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text("Pick your location",
                                style: TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          cubit.AddNewAddress(
                              name: nameController.text,
                              city: cityController.text,
                              region: regionController.text,
                              details: detailsController.text,
                              latitude: lat,
                              long: lon,
                              notes: notesController.text ?? "");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: state is AddNewAddressload? Center(child: CircularProgressIndicator(),): Text("Save Address",
                            style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  );
                },
                listener: (BuildContext context, Object? state) {},
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isOptional = false, bool isEnabel = true}) {
    return TextFormField(
      enabled: isEnabel,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (!isOptional && (value == null || value.trim().isEmpty)) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
