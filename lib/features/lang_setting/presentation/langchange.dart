import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsphere/core/const/const.dart';
import 'package:shopsphere/core/cubit/appCubit/appCubit.dart';
import 'package:shopsphere/core/data/local/cache_helper.dart';
import 'package:shopsphere/features/lang_setting/presentation/widgets/lang_button.dart';
import '../../../core/cubit/appStates/appStates.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      builder: (BuildContext context, state) {
        return  Scaffold(
          appBar: AppBar(
            title: lang!="en"?Text("تغيير اللغه"):Text("change_language"),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LanguageButton(
                    ontab: (){
                      lang="en";
                      CacheHelper.saveData(key: "lang", value: "en");
                      AppCubit.get(context).ChangeLang();

                      print(lang);
                    },
                    title: "English",
                    selected:lang == 'en',
                  ),
                  const SizedBox(height: 20),
                  LanguageButton(
                    ontab: (){
                      lang="ar";
                      CacheHelper.saveData(key: "lang", value: "ar");
                      AppCubit.get(context).ChangeLang();
                      print(lang);
                    },
                    title: "العربية",
                    selected: lang == "ar",
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}

