import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsphere/core/cubit/logincubit/loginCubit.dart';
import 'package:shopsphere/core/states/loginstate/loginStates.dart';

class UpdateUserScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController email=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return BlocConsumer<LoginCubit,LoginSates>(
            builder: (BuildContext context, state) {
              var cubit=LoginCubit.get(context);
              return  SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 500), // for tablets & web
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),
                          _buildTextField(label: cubit.usermodel1.data!.name!, icon: Icons.person, textcontrol: name),
                          const SizedBox(height: 16),
                          _buildTextField(label: cubit.usermodel1.data!.email!, icon: Icons.email, keyboardType: TextInputType.emailAddress, textcontrol: email),
                          const SizedBox(height: 16),
                          _buildTextField(label: cubit.usermodel1.data!.phone!, icon: Icons.phone, keyboardType: TextInputType.phone, textcontrol: phone),
                          const SizedBox(height: 32),
                          ElevatedButton.icon(
                            icon: state is UpdateProfileloadState?Center(child: CircularProgressIndicator(),): Icon(Icons.save),
                            label: const Text("Update"),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.UpdateProfile(name: name.text, email: email.text, phone: phone.text);
                                // handle update logic here
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            listener: (BuildContext context, Object? state) {},
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController textcontrol
  }) {
    return TextFormField(
      controller: textcontrol,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
