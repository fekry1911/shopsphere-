import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsphere/features/auth/presentation/auth/signup.dart';

import '../../../../core/component_widget/reuse/textformfield.dart';
import '../../../../core/component_widget/reuse/toast.dart';
import '../../../../core/theme/colors.dart';
import '../../../bottomnavscreens/presentation/homePage.dart';
import '../../cubit/logincubit/loginCubit.dart';
import '../../cubit/loginstate/loginStates.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phonrController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<LoginCubit, LoginSates>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [maincolor, secondcolor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1, // 10% of screen width
                  vertical: screenHeight * 0.05, // 5% of screen height
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // App Name
                          Text(
                            'ShopSphere',
                            style: TextStyle(
                              fontSize: screenWidth < 600 ? 40 : 48,
                              // Responsive font size
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2.0,
                              shadows: const [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black26,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            'Create Your Account',
                            style: TextStyle(
                              fontSize: screenWidth < 600 ? 16 : 18,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),

                          // Sign-Up Form
                          Container(
                            width: constraints.maxWidth > 600
                                ? 400
                                : double
                                    .infinity, // Max width for large screens
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  // Name Field
                                  TextFormCustom(
                                    Valid: "Please enter your name",
                                    nameController: _nameController,
                                    HintText: 'Full Name',
                                    IconPrefix: Icon(
                                      Icons.person,
                                      color: Colors.white70,
                                    ),
                                    obscureTextl: false,
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  // Email Field
                                  TextFormCustom(
                                    Valid: "Please enter a valid email",
                                    nameController: _emailController,
                                    HintText: 'Email',
                                    IconPrefix: Icon(
                                      Icons.email,
                                      color: Colors.white70,
                                    ),
                                    obscureTextl: false,
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  // Password Field
                                  TextFormCustom(
                                    Valid:
                                        "Password must be at least 6 characters",
                                    nameController: _passwordController,
                                    HintText: 'Password',
                                    IconPrefix: Icon(
                                      Icons.lock,
                                      color: Colors.white70,
                                    ),
                                    obscureTextl: true,
                                  ),
                                  SizedBox(height: screenHeight * 0.02),

                                  TextFormCustom(
                                    Valid: "Please enter your phone number",
                                    nameController: _phonrController,
                                    HintText: 'phone number',
                                    IconPrefix: Icon(
                                      Icons.call,
                                      color: Colors.white70,
                                    ),
                                    obscureTextl: false,
                                  ),
                                  SizedBox(height: screenHeight * 0.03),

                                  // Sign-Up Button
                                  ConditionalBuilder(
                                    condition: state is! REGISTERloadState,
                                    builder: (BuildContext context) {
                                      return  ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            // Add your sign-up logic here
                                            var cubit = LoginCubit.get(context);
                                            cubit.RegisterUser(
                                                email: _emailController.text,
                                                password:
                                                _passwordController.text,
                                                phone: _phonrController.text,
                                                name: _nameController.text).then((value){

                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: secondcolor,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.15,
                                            vertical: 15,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          elevation: 10,
                                        ),
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: maincolor,
                                          ),
                                        ),
                                      );

                                    },
                                    fallback: (BuildContext context) {
                                      return Center(child: CircularProgressIndicator(),);
                                    },
                                  ),
                                  SizedBox(height: screenHeight * 0.02),

                                  // Back to Login
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                        context,
                                      ); // Go back to login screen
                                    },
                                    child: const Text(
                                      'Already have an account? Login',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if(state is REGISTERsucState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        }
      },
    );
  }
}
