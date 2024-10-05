import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:storeapp/utils/base_text.dart';

import '../../../app_database/app_database.dart';
import '../../../utils/base_button.dart';
import '../../../utils/base_color.dart';
import '../controller/home_controller.dart';
import 'package:drift/drift.dart' as drift;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late HomeController controller;

  @override
  void initState() {
    if (Get.isRegistered<HomeController>()) {
      controller = Get.find<HomeController>();
    } else {
      controller = Get.put(HomeController());
    }
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      // Execute callback if page is mounted
      // try{
      //   await controller.getCartProduct(context, {});
      // }catch(e){
      //   Get.back();
      // }

      try {
        await controller.getMyDownloads();
      } catch (e) {
        // ignore: use_build_context_synchronously
        // myCustomErrorToast(e, context);
        Get.back();
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BaseText(value: 'Your cart is empty', fontSize: 22),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                radius: 15,
                width: 220,
                borderWidth: 0.1,
                onPressed: () async {
                  Get.back();
                },
                child: const Center(
                  child: BaseText(
                    value: "Continue Shopping",
                    color: BaseColors.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ));
        }

        return ListView.builder(
          itemCount: controller.cartItems.length,
          itemBuilder: (context, index) {
            final item = controller.cartItems[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Product Image
                    Image.network(
                      item.image ?? '',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10), // Space between image and text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: BaseText(
                                    value: item.title ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 4), // Space between title and price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              BaseText(
                                value: 'Price: \$${item.price}',
                                fontSize: 18,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove,
                                      size: 35,
                                    ),
                                    onPressed: () async {
                                      var data = await MyDatabase()
                                          .getAudioById(item.id ?? 0);
                                      if (data != null) {
                                        if (data.productQuantity > 1) {
                                          var downnload =
                                              await MyDatabase().updateAudioData(
                                                  item.id!,
                                                  AudioTableCompanion(
                                                      productQuantity:
                                                          drift.Value.ofNullable(
                                                              (data.productQuantity -
                                                                  1)),
                                                      imagePath:
                                                          drift.Value.ofNullable(
                                                              item.image),
                                                      productId: drift.Value
                                                          .ofNullable(item.id),
                                                      modelJson:
                                                          drift.Value.ofNullable(
                                                              jsonEncode(item))));
                                          controller.cartItems[index].quantity =
                                              controller.cartItems[index]
                                                      .quantity! -
                                                  1;
                                          controller.calculateTotalPrice();
                                          controller.cartItems.refresh();
                                          // cartProvider.updateQuantity(item.id, item.quantity! - 1);
                                        } else {
                                          var data = await MyDatabase()
                                              .deleteProduct(item.id ?? 0);
                                          controller.cartItems.removeAt(index);
                                          controller.calculateTotalPrice();
                                          controller.cartItems.refresh();
                                          Fluttertoast.showToast(
                                              msg: 'Successfully Remove Cart');

                                          // cartProvider.updateQuantity(item.id, 0);
                                        }
                                      }
                                    },
                                  ),
                                  BaseText(value: '${item.quantity}'),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      size: 35,
                                    ),
                                    onPressed: () async {
                                      var downnload = await MyDatabase()
                                          .updateAudioData(
                                              item.id!,
                                              AudioTableCompanion(
                                                  productQuantity:
                                                      drift.Value.ofNullable(
                                                          (item.quantity! + 1)),
                                                  imagePath:
                                                      drift.Value.ofNullable(
                                                          item.image),
                                                  productId:
                                                      drift.Value.ofNullable(
                                                          item.id),
                                                  modelJson:
                                                      drift.Value.ofNullable(
                                                          jsonEncode(item))));
                                      controller.cartItems[index].quantity =
                                          controller
                                                  .cartItems[index].quantity! +
                                              1;
                                      controller.calculateTotalPrice();
                                      controller.cartItems.refresh();

                                      // cartProvider.updateQuantity(item.id, item.quantity + 1);
                                    },
                                  ),
                                ],
                              )
                            ],
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
      }),
      // Floating Action Button to display total amount
      floatingActionButton:  SizedBox(
            height: 100,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 16,
                      child: FloatingActionButton(
                        onPressed: () {
                          // Navigate to checkout or cart summary
                          // Get.to(CheckoutScreen()); // Replace with your navigation logic
                        },
                        backgroundColor: BaseColors.primaryColor,
                        // Customize button color
                        child: const Icon(Icons.shopping_cart_checkout, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      bottom: 10, // Position above the button
                      left: 20, // Slight offset for balance
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Obx(() {
                          return Wrap(
                            children: [
                              const Text(
                                "Total: ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "\$${controller.totalPrice.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
