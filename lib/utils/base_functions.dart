import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

var currentBackPressTime;

Future<bool> onWillPop() {
  log('currentBackPressTime $currentBackPressTime');
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

triggerHapticFeedback() {
  if (Platform.isAndroid) {
    HapticFeedback.vibrate();
  } else {
    HapticFeedback.lightImpact();
  }
}
SizedBox buildSizeHeight(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox buildSizeWidth(double width) {
  return SizedBox(
    width: width,
  );
}

double mediaQueryWidth(BuildContext context, double width) {
  return MediaQuery.of(context).size.width * width;
}

double mediaQueryHeight(BuildContext context, double height) {
  return MediaQuery.of(context).size.height * height;
}

void showLoader(context) async => await showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => WillPopScope(
    onWillPop: () async => false,
    child: Container(
      color: Colors.black12,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    ),
  ),
);