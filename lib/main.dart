import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shopsphere/core/const/const.dart';
import 'package:shopsphere/core/cubit/appCubit/appCubit.dart';
import 'package:shopsphere/core/cubit/logincubit/loginCubit.dart';
import 'package:shopsphere/core/data/local/cache_helper.dart';
import 'package:shopsphere/features/screens/homePage.dart';

import 'core/cubit/observal.dart';
import 'core/data/api/api.dart';
import 'core/data/api/paymentapi.dart';
import 'features/screens/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Add this line
  DioHelper.init();
  PaymopPayment.init();
  Bloc.observer = SimpleBlocObserver();
  await CacheHelper.init();
  TOKEN = CacheHelper.getData(key: "token") ?? "";
  lang = CacheHelper.getData(key: "lang") ?? "en";
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          print(
              "enter to appcubit done akmscnjbsancfksdbivhifbasnokpdffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
          return AppCubit()
            ..GetHomeData()
            ..GetCategories()
            ..GetFavorites()
            ..GetCarts()
            ..GetAllProdects()
            ..GetAdresses();
        }),
        BlocProvider(create: (context) {
          print(
              "enter to appcubit done akmscnjbsancfksdbivhifbasnokpdffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
          return LoginCubit()..GetProfileData();
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: CacheHelper.getData(key: "token") == null
            ? SplashScreen()
            : HomePage(),
      ),
    );
  }
}
