import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_database/app_database.dart';
import '../../../res/api_manager.dart';
import '../../../res/api_model.dart';
import '../../../utils/base_functions.dart';
import '../../../utils/local_storage.dart';
import '../model/product_list.dart';

class HomeController extends GetxController {
  final APIManager _apiManager = APIManager.apiManagerInstanace;

  // final APIS _apis = APIS.apisSharedInstanace;
  final LocalStorage _localStorage = LocalStorage.localStorageSharedInstance;

  var productCategory = <String>[].obs;

  final productList = <ProductListModel>[].obs;

  final cartItems = <ProductListModel>[].obs;

  var totalPrice = 0.0.obs;
  RxString selectedCategory = ''.obs;


  // var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Whenever cartItems changes, update totalPrice
    ever(cartItems, (_) => calculateTotalPrice());
  }

  // Function to calculate total price
  void calculateTotalPrice() {
    totalPrice.value = cartItems.fold(0.0, (sum, item) => sum + (item.price! * item.quantity!));
  }

  //Categories Category
  Future<void> getCategories(BuildContext context, Map<String, dynamic> param,
      {bool isResend = false}) async {
    showLoader(context);
    ApiResponseModel apiResponse = await _apiManager.request(
      'https://fakestoreapi.com/products/categories',
      Method.get,
      param,
    );
    log("Category API Response -----> ${apiResponse.data}");
    log("Login API Response -----> ${apiResponse.status}");
    log("Login API Response -----> ${apiResponse.error}");
    if (apiResponse.status) {
      Get.back();
      productCategory.addAll(apiResponse.data.cast<String>());

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // Execute callback if page is mounted
        try {
          selectedCategory.value = productCategory.first;
          await getProduct(context, {}, category: productCategory.first);
        } catch (e) {
          Get.back();
        }
      });
      print('object --- > ${productCategory}');
    } else {
      log("Login Message.. ${apiResponse.error?.statusCode}");
      throw HttpException(apiResponse.error?.description ?? '');
    }
  }

  Future<void> getProduct(BuildContext context, Map<String, dynamic> param,
      {bool isResend = false, String? category}) async {
    showLoader(context);
    ApiResponseModel apiResponse = await _apiManager.request(
      'https://fakestoreapi.com/products/category/$category',
      Method.get,
      param,
    );
    log("Category API Response -----> ${apiResponse.data}");
    log("Login API Response -----> ${apiResponse.status}");
    log("Login API Response -----> ${apiResponse.error}");
    if (apiResponse.status) {
      Get.back();
      productList.clear();
      productList.addAll((apiResponse.data as List)
          .map((item) => ProductListModel.fromJson(item))
          .toList());
    } else {
      log("Login Message.. ${apiResponse.error?.statusCode}");
      throw HttpException(apiResponse.error?.description ?? '');
    }
  }

  Future<void> getProductById(BuildContext context, Map<String, dynamic> param,
      {bool isResend = false, String? productId}) async {
    showLoader(context);
    ApiResponseModel apiResponse = await _apiManager.request(
      'https://fakestoreapi.com/products/$productId',
      Method.get,
      param,
    );
    log("Category API Response -----> ${apiResponse.data}");
    log("Login API Response -----> ${apiResponse.status}");
    log("Login API Response -----> ${apiResponse.error}");
    if (apiResponse.status) {
      Get.back();
      productList.clear();
      productList.addAll((apiResponse.data as List)
          .map((item) => ProductListModel.fromJson(item))
          .toList());
    } else {
      log("Login Message.. ${apiResponse.error?.statusCode}");
      throw HttpException(apiResponse.error?.description ?? '');
    }
  }

  Future<void> addToCart(BuildContext context, Map<String, dynamic> param,
      {bool isResend = false, String? productId}) async {
    showLoader(context);
    ApiResponseModel apiResponse = await _apiManager.request(
      'https://fakestoreapi.com/carts',
      Method.post,
      param,
    );
    log("Category API Response -----> ${apiResponse.data}");
    log("Login API Response -----> ${apiResponse.status}");
    log("Login API Response -----> ${apiResponse.error}");
    if (apiResponse.status) {
      Get.back();
    } else {
      log("Login Message.. ${apiResponse.error?.statusCode}");
      throw HttpException(apiResponse.error?.description ?? '');
    }
  }

  Future<void> getCartProduct(BuildContext context, Map<String, dynamic> param,
      {bool isResend = false, String? category}) async {
    showLoader(context);
    ApiResponseModel apiResponse = await _apiManager.request(
      'https://fakestoreapi.com/products/category/$category',
      Method.get,
      param,
    );

    if (apiResponse.status) {
      Get.back();
      productList.clear();
      productList.addAll((apiResponse.data as List)
          .map((item) => ProductListModel.fromJson(item))
          .toList());
    } else {
      log("Login Message.. ${apiResponse.error?.statusCode}");
      throw HttpException(apiResponse.error?.description ?? '');
    }
  }

  Future<void> getMyDownloads() async {
    cartItems.clear();
    var data = await MyDatabase().getAudioData();
    data.forEach((e) {
      print('eee-> $e');
      cartItems.add(ProductListModel(
        id: e.productId,
        quantity: e.productQuantity,
        image: e.imagePath,
        title: ProductListModel.fromJson(jsonDecode(e.modelJson)).title,
        price: ProductListModel.fromJson(jsonDecode(e.modelJson)).price,
        description:
            ProductListModel.fromJson(jsonDecode(e.modelJson)).description,
        category: ProductListModel.fromJson(jsonDecode(e.modelJson)).category,
        rating: ProductListModel.fromJson(jsonDecode(e.modelJson)).rating,
      ));
    });

    print('cartItems --- > ${cartItems}');
  }
}
