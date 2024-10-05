import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:storeapp/moduls/auth/screen/login_screen.dart';
import 'package:storeapp/moduls/dashboard/controller/home_controller.dart';
import 'package:storeapp/moduls/dashboard/screen/product_details_screen.dart';
import 'package:storeapp/utils/base_color.dart';
import 'package:storeapp/utils/base_text.dart';

import '../../../app_database/app_database.dart';
import '../../../utils/local_storage.dart';
import 'cart_screen.dart';

var currentBackPressTime;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;
  final LocalStorage _localStorage = LocalStorage.localStorageSharedInstance;


  @override
  void initState() {
    if (Get.isRegistered<HomeController>()) {
      controller = Get.find<HomeController>();
    } else {
      controller = Get.put(HomeController());
    }
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      // Execute callback if page is mounted
      try {
        await controller.getCategories(context, {});
      } catch (e) {
        Get.back();
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
            top: true,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 80,
                title: const BaseText(
                  value: 'E-Commerce App',
                  fontSize: 22,
                ),
                centerTitle: false,
                backgroundColor: BaseColors.greenColor,
                // You can customize the color
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.logout, color: BaseColors.whiteColor,
                      size: 30,),
                    onPressed: () async {
                      // Navigate to cart screen
                      _localStorage.clearStorage();
                      var data = await MyDatabase().deleteEverything();
                      // Navigate to Login screen
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false,); // Update this with your profile screen
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.person, color: BaseColors.whiteColor, size: 30,),
                    onPressed: () {
                      // Navigate to profile screen
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ProfileScreen()), // Update this with your profile screen
                      // );
                    },
                  ),
                ],
              ),
              body: Column(
                children: [
                  Container(
                    color: BaseColors.boarderColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2, vertical: 5),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 2, vertical: 3),
                    height: 45,
                    // Height of the category row
                    child: Obx(() {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // Set scrolling direction to horizontal
                        itemCount: controller.productCategory.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              try {
                                var map = <String, dynamic>{};
                                controller.selectedCategory.value =
                                controller.productCategory[index];
                                await controller.getProduct(context, map,
                                    category:
                                    controller.productCategory[index]);
                              } catch (e) {
                                log('Sign Up Error ---> ${e.toString()}');

                                // myCustomErrorToast(e, context);
                                Navigator.pop(context);
                              }
                            },
                            child: CategoryCard(
                              name: controller.productCategory[index],
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  // Other content on the home screen can go here...
                  Expanded(
                    child: Center(child: Obx(() {
                      return GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // Adjust for more or fewer columns
                          childAspectRatio: 0.7,
                          // Adjust aspect ratio for item size
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: controller.productList.length,
                        itemBuilder: (context, index) {
                          final product = controller.productList[index];
                          return GestureDetector(
                            onTap: () {
                              print('product -- > ${product.id}');
                              // Handle product tap
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailsScreen(product: product),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius:
                                      const BorderRadius.vertical(
                                          top: Radius.circular(8.0)),
                                      child: Image.network(
                                        product.image ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title ?? '',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '\$${product.price}',
                                          style: const TextStyle(
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    })),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  // Navigate to the CartScreen when pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                child: const Icon(Icons.shopping_cart),
                tooltip: 'Go to Cart',
              ),
            )));
  }

  Future<bool> onWillPop() {
    print('currentBackPressTime $currentBackPressTime');
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press back again to exit');
      return Future.value(false);
    }
    currentBackPressTime = null;
    return Future.value(true);
  }
}

class CategoryCard extends StatelessWidget {
  final String name;

  HomeController controller = Get.find<HomeController>();
  CategoryCard({super.key, required this.name,});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: 140, // Width of each category card
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: controller.selectedCategory.value ==
              name ? BaseColors.secondaryColor.withOpacity(0.5) : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            name.capitalizeFirst ?? ' ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: BaseColors.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    });
  }
}
