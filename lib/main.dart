import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shopsphere/core/const/const.dart';
import 'package:shopsphere/core/data/local/cache_helper.dart';
import 'app.dart';
import 'core/cubit/observal.dart';
import 'core/network/api/api.dart';
import 'features/payment/data/repository/paymentapi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  PaymopPayment.init();
  Bloc.observer = SimpleBlocObserver();
  await CacheHelper.init();
  TOKEN = CacheHelper.getData(key: "token") ?? "";
  lang = CacheHelper.getData(key: "lang") ?? "en";
  runApp(Phoenix(child: MyApp()));
}

