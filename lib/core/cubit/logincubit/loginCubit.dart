import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopsphere/core/data/api/api.dart';
import 'package:shopsphere/core/data/local/cache_helper.dart';

import '../../const/const.dart';
import '../../models/usermodel.dart';
import '../../models/usermodel2.dart';
import '../../states/loginstate/loginStates.dart';
import '../appCubit/appCubit.dart';

class LoginCubit extends Cubit<LoginSates> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  usermodel Model = usermodel();
  usermodel2 usermodel1 = usermodel2();

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    await DioHelper.postData(
      path: login,
      data: {"email": email, "password": password},
    ).then((onValue) {
      Model = usermodel.fromJson(onValue.data);
      print(onValue.data);
      // print(Model.data!.email);
      CacheHelper.saveData(key: "token", value: Model.data!.token!);
      CacheHelper.saveData(key: "name", value: Model.data!.name);
      CacheHelper.saveData(key: "mail", value: Model.data!.email);
      CacheHelper.saveData(key: "phone", value: Model.data!.phone);


      TOKEN = CacheHelper.getData(key: "token");
      GetProfileData();
      emit(LoginsuccState(Model));
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginFailState(Model));
    });
  }

  Future<void> RegisterUser({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    emit(REGISTERloadState());
    await DioHelper.postData(
      path: REGISTER,
      data: {
        "email": email,
        "password": password,
        "name": name,
        "phone": phone,
        "image": ""
      },
    ).then((onValue) {
      Model = usermodel.fromJson(onValue.data);
      print(onValue.data);
      // print(Model.data!.email);
      emit(REGISTERsucState());
    }).catchError((onError) {
      print(onError.toString());
      emit(REGISTERfailState());
    });
  }

  Future<void> GetProfileData() async {
    emit(GetProfileloadState());
    DioHelper.getData(url: PROFILE, token: TOKEN).then((onValue) {
      usermodel1 = usermodel2.fromJson(onValue.data);
      print(usermodel1.data!.name!);
      emit(GetProfilesucState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetProfilefailState());
    });
  }

  Future<void> LogOut() async {
    DioHelper.postData(path: "logout").then((onValue) async {
      CacheHelper.removeData(key: "token");

      emit(Logoutsucc());
    }).catchError((onError) {
      emit(logoutfail());
    });
  }

  void UpdateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(UpdateProfileloadState());
    DioHelper.putData(
        path: UPDATE_PROFILE,
        token: TOKEN,
        data: {
          "name": name,
          "phone": phone,
          "email": email,
        }
    )
        .then((onValue) {
      CacheHelper.saveData(key: "name", value: onValue.data["name"]);
      CacheHelper.saveData(key: "email", value: onValue.data["email"]);
      CacheHelper.saveData(key: "phone", value: onValue.data["phone"]);

      print(onValue.data);
      GetProfileData();
      emit(UpdateProfilesucState());
    }).catchError((onError) {
      print(onError.toString());
      emit(UpdateProfilefailState());
    });
  }
}
