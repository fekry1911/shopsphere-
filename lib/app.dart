import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/cubit/appCubit/appCubit.dart';
import 'core/data/local/cache_helper.dart';
import 'features/auth/cubit/logincubit/loginCubit.dart';
import 'features/bottomnavscreens/presentation/homePage.dart';
import 'features/splash/splashscreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return AppCubit()
            ..GetHomeData()
            ..GetCategories()
            ..GetFavorites()
            ..GetCarts()
            ..GetAllProdects()
            ..GetAdresses();
        }),
        BlocProvider(create: (context) {
          return LoginCubit()..GetProfileData();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: CacheHelper.getData(key: "token") == null
            ? SplashScreen()
            : HomePage(),
      ),
    );
  }
}
