import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:storeapp/moduls/dashboard/controller/home_controller.dart';

import '../../../app_database/app_database.dart';
import '../../../utils/base_button.dart';
import '../../../utils/base_color.dart';
import '../../../utils/base_functions.dart';
import '../../../utils/base_text.dart';
import '../model/product_list.dart';
import 'package:drift/drift.dart' as drift;

import 'cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductListModel product;

  ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late int selectedQuantity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedQuantity = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title ?? 'Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display product image
              Center(
                child: Image.network(
                  widget.product.image ?? '',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              // Display product title
              Text(
                widget.product.title ?? '',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              // Display product price
              Text(
                '\$${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8.0),
              // Display product description
              Text(
                widget.product.description ?? '',
                style: const TextStyle(
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8.0),
              // Display product category
              Text(
                'Category: ${widget.product.category ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8.0),
              // Display product rating
              if (widget.product.rating != null)
                Row(
                  children: [
                    Text(
                      'Rating: ${widget.product.rating!.rate?.toStringAsFixed(1) ?? 'N/A'}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '(${widget.product.rating!.count ?? 0} reviews)',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16.0),
              // Quantity selection
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quantity:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (selectedQuantity > 1) {
                            setState(() {
                              selectedQuantity = selectedQuantity - 1;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(selectedQuantity.toString()),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedQuantity = selectedQuantity + 1;
                          });
                          print(selectedQuantity);
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Add to cart button
              CustomButton(
                radius: 15,
                borderWidth: 0.1,
                onPressed: () async {
                  showLoader(context);
                  print('data == null --- > ${widget.product.id}');
                  var data =
                      await MyDatabase().getAudioById(widget.product.id ?? 0);
                  print('data == null --- > ${data?.productQuantity}');
                  if (data == null) {
                    var downnload = await MyDatabase().insertAudioData(
                        AudioTableCompanion(
                            productQuantity:
                                drift.Value.ofNullable(selectedQuantity),
                            imagePath:
                                drift.Value.ofNullable(widget.product.image),
                            productId:
                                drift.Value.ofNullable(widget.product.id),
                            modelJson: drift.Value.ofNullable(
                                jsonEncode(widget.product))));
                    Fluttertoast.showToast(msg: 'Add Successfully Cart');
                    print('downnload --- ${downnload}');
                  } else {
                    var downnload = await MyDatabase().updateAudioData(
                        widget.product.id!,
                        AudioTableCompanion(
                            productQuantity: drift.Value.ofNullable(
                                (data!.productQuantity + selectedQuantity)),
                            imagePath:
                                drift.Value.ofNullable(widget.product.image),
                            productId:
                                drift.Value.ofNullable(widget.product.id),
                            modelJson: drift.Value.ofNullable(
                                jsonEncode(widget.product))));
                    Fluttertoast.showToast(msg: 'Add Successfully Cart');
                    print('update --- ${downnload}');
                  }
                  Get.back();

                  // _addToCart(context);
                },
                child: const Center(
                  child: BaseText(
                    value: "Add to Cart",
                    color: BaseColors.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
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
        tooltip: 'Go to Cart',
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

extension HelperCalls on _ProductDetailsScreenState {
  void _addToCart(context) async {
    final HomeController cartController = Get.find();
    Future.delayed(Duration.zero, () => FocusScope.of(context).unfocus());
    try {
      var map = <String, dynamic>{};
      map['userId'] = '1';
      map['products'] = [];
      print('Map ---  >$map');
      await cartController.addToCart(context, map);
      Fluttertoast.showToast(msg: 'Add Successfully Cart');
    } catch (e) {
      log('Sign Up Error ---> ${e.toString()}');

      // myCustomErrorToast(e, context);
      Navigator.pop(context);
    }
    // }
  }
}
