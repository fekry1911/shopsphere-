import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shopsphere/core/network/api/api.dart';
import 'package:shopsphere/features/product/data/models/prodectModel2.dart';
import '../../../features/cart/data/models/cartmodel1.dart';
import '../../../features/cart/presentaion/cart.dart';
import '../../../features/categories/presentaion/categories.dart';
import '../../../features/favorites/data/models/favoritesmodel.dart';
import '../../../features/favorites/presentation/favorites.dart';
import '../../../features/home/presentation/homeScreens.dart';
import '../../../features/user_setting/presentaion/userdata2.dart';
import '../../component_widget/reuse/toast.dart';
import '../../const/const.dart';
import '../../../features/payment/data/repository/paymentapi.dart';
import '../../../features/user_adresses/data/models/adressesmodel.dart';
import '../../../features/categories/data/models/categoriesmodel.dart';
import '../../../features/product/data/categoriesprodects.dart';
import '../../../features/home/data/models/homeModel.dart';
import '../../../features/payment/data/models/paymentmodel.dart';
import '../../../features/product/data/models/prodectmodel.dart';
import '../appStates/appStates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);
  homeModel? homemodel1 = homeModel();

  int index1 = 0;
  List<Widget> Screens = [
    HomeScreen(),
    Categories(),
    Favorites(),
    Cart(),
    ProfileScreen()
  ];
  List<String> titles = ["Home", "Categories", "Favorites", "Cart"];

  void CangeIndex(index) {
    print("token is : $TOKEN");
    index1 = index;
    //GetHomeData();
    if (index == 2) {
      GetFavorites();
    }
    print(TOKEN);
    emit(ChangeBottomNavIndexState());
  }

  Future<void> GetHomeData() async {
    emit(GetDataHomeLoadState());
    await DioHelper.getData(url: Home, token: TOKEN).then((value) {
      GetFavorites();
      homemodel1 = homeModel.fromJson(value.data);
      print(homemodel1!.data!.products![0].name!);
      emit(GetDataHomeSuccState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetDataHomeFailState());
    });
  }

  ProdectDetilsModel prodect = ProdectDetilsModel();

  Future<void> GetProdectDetails(int prodectid) async {
    emit(GetDataHProdectLoadState());
    await DioHelper.getData(url: "$PRODECTSDETAILS/$prodectid", token: TOKEN)
        .then((value) {
      prodect = ProdectDetilsModel.fromJson(value.data);

      print(prodect.data!.name!);
      emit(GetProdectDetailsSuccState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetProdectDetailsfailState());
    });
  }

  CategoreModel categoreModel = CategoreModel();

  Future<void> GetCategories() async {
    emit(GetDataHomeLoadState());
    await DioHelper.getData(url: CATEGORIES, token: TOKEN).then((value) {
      categoreModel = CategoreModel.fromJson(value.data);
      print(categoreModel.data);
      emit(GetGetCategoriesSuccState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetGetCategoriesfailState());
    });
  }

  ProdectsInCategoriesModel categoriesModel = ProdectsInCategoriesModel();

  Future<void> GetCategoriesDEtails(int Categoreid) async {
    emit(GetDataHomeLoadState());
    await DioHelper.getData(url: "$CATEGORIES/$Categoreid", token: TOKEN)
        .then((value) {
      categoriesModel = ProdectsInCategoriesModel.fromJson(value.data);
      print(categoriesModel!.data);
      emit(GetGetCategoriesDEtailsSuccState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetGetCategoriesDEtailsfailState());
    });
  }

  bool max = false;

  void expandtext() {
    max = !max;
    emit(ExpandTextMax());
  }

  FavoritesModel favoritesModel = FavoritesModel();

  Map<int, bool> favdata = {};
  Map<int, bool> cartdata = {};

  Future<void> AddOrRemoveToFav({
    required int id,
    required context,
  }) async {
    favdata[id] = !favdata[id]!;
    emit(AddOrRemoveToFavSuccState());
    DioHelper.postData(path: FAVORITES, token: TOKEN, data: {"product_id": id})
        .then((onValue) {
      if (!onValue.data["status"]) {
        favdata[id] = !favdata[id]!;
      }
      ShowToast(
          context: context, icon: Icons.done, message: onValue.data["message"]);

      GetFavorites();
      print(onValue.data);
      emit(AddOrRemoveToFavSuccState());
    }).catchError((onError) {
      favdata[id] = !favdata[id]!;
      print(onError.toString());
      emit(AddOrRemoveToFavfailState());
    });
  }

  Future<void> AddOrRemoveToCart({
    required context,
    required int id,
  }) async {
    cartdata[id] = !cartdata[id]!;
    DioHelper.postData(path: CARTS, token: TOKEN, data: {"product_id": id})
        .then((onValue) {
      if (!onValue.data["status"]) {
        cartdata[id] = !cartdata[id]!;
      }
      ShowToast(
          context: context, icon: Icons.done, message: onValue.data["message"]);

      print(onValue.data);
      GetCarts();
      emit(AddOrRemoveToCartSuccState());
    }).catchError((onError) {
      cartdata[id] = !cartdata[id]!;
      print(onError.toString());
      emit(AddOrRemoveToCartfailState());
    });
  }

  void GetFavorites() {
    DioHelper.getData(url: FAVORITES, token: TOKEN).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print("122222234123123123123123123");
      print(favoritesModel!.data!.data2![0].id);
      emit(GetFavStatesucc());
    }).catchError((onError) {
      emit(GetFavStatefail());
    });
  }

  void UpdateCart({
    required int id,
    required int quantity,
  }) {
    emit(AddOrRemoveToCartloadState());
    DioHelper.putData(
        path: "$CARTS/$id",
        token: TOKEN,
        data: {"quantity": quantity}).then((onValue) {
      print(onValue.data);
      GetCarts();
      emit(AddOrRemoveToCartSuccState());
    }).catchError((onError) {
      print(onError.toString());
      emit(AddOrRemoveToCartfailState());
    });
  }

  cartmodel cartmodel1 = cartmodel();

  void GetCarts() {
    DioHelper.getData(url: CARTS, token: TOKEN).then((value) {
      cartmodel1 = cartmodel.fromJson(value.data);
      print("122222234123123123123123123");
      print(favoritesModel!.data!.data2![0].id);
      emit(GetcartStatesucc());
    }).catchError((onError) {
      emit(GetcartStatefail());
    });
  }

  void DeleteCart({
    required int id,
  }) {
    DioHelper.deleteData(
      path: "$CARTS/$id",
      token: TOKEN,
    ).then((onValue) {
      GetCarts();
    });
  }

  prodectmodel prodectmodel1 = prodectmodel();

  void GetAllProdects() {
    DioHelper.getData(url: PRODECTS, token: TOKEN).then((value) {
      prodectmodel1 = prodectmodel.fromJson(value.data);
      prodectmodel1.data!.data!.forEach((e) {
        favdata.addAll({e.id!: e.inFavorites!});
        print(e.id);
      });
      prodectmodel1.data!.data!.forEach((e) {
        cartdata.addAll({e.id!: e.inCart!});
        print(e.id);
      });
      print("122222234123123123123123123");
      print(favoritesModel!.data!.data2![0].id);
      emit(GetAllprodectssucc());
    });
  }

  /*/ void GetAllDAta(){
    GetHomeData();
    GetCategories();
    GetFavorites();
    GetCarts();
    GetAllProdects();
  }*/

  AddressesModel adressmodel = AddressesModel();

  void GetAdresses() {
    DioHelper.getData(url: Adresses, token: TOKEN).then((value) {
      adressmodel = AddressesModel.fromJson(value.data);
      print(adressmodel.data!.data!.length);
      print("122222234123123123123123123");
      print(favoritesModel.data!.data2![0].id);
      emit(GetAddresssucc());
    });
  }
   PaymentModel details1=PaymentModel(name: "", email: "", city: "", street: '', phone_number: '');

  Future<String> initiatePayment({required int amount,}) async {
    emit(initiatePaymentload());
    final authToken = await PaymopPayment().getAuthToken();
    final orderId =
        await PaymopPayment().GetOrdreid(authToken: authToken, amount: amount);
    final paymentToken = await PaymopPayment()
        .getPaymentKey(authToken: authToken, amount: amount, orderId: orderId, details: details1);
    emit(initiatePaymentdone());
    return paymentToken;
  }

  void ChangeLang() {
    emit(ChangeLangDone());
    GetHomeData();
    GetFavorites();
    GetCarts();
    GetCategories();
    emit(ChangeLangDone());
  }

  void AddNewAddress({
    required String name,
    required String city,
    required String region,
    required String details,
    double? latitude,
    double? long,
    String? notes,
  }) {
    emit(AddNewAddressload());

    DioHelper.postData(path: Adresses, token: TOKEN, data: {
      "name": name,
      "city": city,
      "region": region,
      "details": details,
      "latitude": latitude?? 0.0,
      "longitude": long?? 0.0,
      "notes": notes ?? ""
    }).then((onValue) {
      GetAdresses();
      print("done");
      emit(AddNewAddressDone());
    }).catchError((onError) {
      emit(AddNewAddressFail());
    });
  }

  Future<Position> getCurrentLocation() async {
    emit(GelLocLoad());

    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied';
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((x) {
      emit(GelLocDone());
      return x;
    });
  }
  int? selectedAddressType;

  void select(value){
    selectedAddressType=value;
    emit(SelectAddress());
  }
  String? selectedPaymentMethod;

  void setPaymentMethod(String method) {
    selectedPaymentMethod = method;
    emit(PaymentMethodChangedState());
  }
}

