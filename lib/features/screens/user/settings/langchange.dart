import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopsphere/core/const/const.dart';
import 'package:shopsphere/core/cubit/appCubit/appCubit.dart';
import 'package:shopsphere/core/data/local/cache_helper.dart';
import 'package:shopsphere/core/states/appStates/appStates.dart';

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

class LanguageButton extends StatelessWidget {
  final String title;
  final bool selected;
  final ontab;

  const LanguageButton({
    required this.title,
    required this.ontab,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        selected ? Icons.check_circle : Icons.language,
        color: selected ? Colors.green : null,
      ),
      label: Text(title, style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        backgroundColor: selected ? Colors.green.shade100 : null,
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: ontab,
    );
  }
}
