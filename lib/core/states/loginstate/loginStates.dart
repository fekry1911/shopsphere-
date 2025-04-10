import 'package:flutter/physics.dart';

import '../../models/usermodel.dart';

abstract class LoginSates {}

class InitialState extends LoginSates {}

class LoginsuccState extends LoginSates {
  LoginsuccState(this.LoginModel);

  late usermodel? LoginModel;
}

class LoginLoadingState extends LoginSates {}

class LoginFailState extends LoginSates {
  LoginFailState(this.LoginModel);

  late usermodel? LoginModel;
}

class REGISTERloadState extends LoginSates {}

class REGISTERsucState extends LoginSates {}

class REGISTERfailState extends LoginSates {}

class GetProfileloadState extends LoginSates {}

class GetProfilesucState extends LoginSates {}

class GetProfilefailState extends LoginSates {}

class UpdateProfileloadState extends LoginSates {}

class UpdateProfilesucState extends LoginSates {}

class UpdateProfilefailState extends LoginSates {}
class Logoutsucc extends LoginSates {}

class logoutfail extends LoginSates {}