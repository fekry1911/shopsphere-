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


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocConsumer<LoginCubit,LoginSates>(
        builder: (context,state) {
          var cubit = LoginCubit.get(context);
          return Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [maincolor, secondcolor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1, // 10% of screen width
                  vertical: screenHeight * 0.05, // 5% of screen height
                ),
                child: Center(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Center(
                        child: ListView(
                          children: [

                            // Logo and App Name
                            FadeTransition(
                              opacity: _fadeAnimation,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ShopSphere',
                                      style: TextStyle(
                                        fontSize: screenWidth < 600 ? 40 : 48,
                                        // Smaller on phones, larger on tablets
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
                                    SizedBox(height: screenHeight * 0.015),
                                    Text(
                                      'Your World of Shopping',
                                      style: TextStyle(
                                        fontSize: screenWidth < 600 ? 16 : 18,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.07),
                            // Responsive spacing
                            // Login Form
                            Container(
                              width:
                                  constraints.maxWidth > 600
                                      ? 400
                                      : double.infinity,
                              // Caps width on larger screens
                              padding: EdgeInsets.all(screenWidth * 0.05),
                              // Responsive padding
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
                                      Valid: "Password must be at least 6 characters",
                                      nameController: _passwordController,
                                      HintText: 'Password',
                                      IconPrefix: Icon(
                                        Icons.lock,
                                        color: Colors.white70,
                                      ),
                                      obscureTextl: true,
                                    ),
                                    SizedBox(height: screenHeight * 0.03),
                                    // Login Button
                                    ConditionalBuilder(condition: state is! LoginLoadingState, builder: (context){
                                      return ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            // Add your login logic here
                                            cubit.loginUser(
                                              email: _emailController.text,
                                              password: _passwordController.text,
                                            ).then((valur){
                                              //print(cubit.Model.data!.id);
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: secondcolor,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.15,
                                            // Responsive button width
                                            vertical: 15,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          elevation: 10,
                                        ),
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: screenWidth < 600 ? 16 : 18,
                                            fontWeight: FontWeight.bold,
                                            color: maincolor,
                                          ),
                                        ),
                                      );
                                    }, fallback: (context){
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }),
                                    SizedBox(height: screenHeight * 0.025),

                                    // Forgot Password & Sign Up
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: screenWidth < 600 ? 14 : 16,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        const SignUpScreen(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: screenWidth < 600 ? 14 : 16,
                                            ),
                                          ),
                                        ),
                                      ],
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
        listener: (context,state) {
          if(state is LoginsuccState){

            if(state.LoginModel!.status!){
              print(state.LoginModel!.message);
               ShowToast(context: context,icon: Icons.done,message: state.LoginModel!.message!);
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
            }


          }
          if(state is LoginFailState){
            ShowToast(context: context,icon: Icons.done,message: state.LoginModel!.message!);

          }

        },
      ),
    );
  }
}

