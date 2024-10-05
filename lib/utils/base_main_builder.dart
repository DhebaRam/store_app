import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:scaled_app/scaled_app.dart';

import 'base_color.dart';
import 'base_text.dart';
import 'customised_grey_error_screen.dart';

class BaseMainBuilder extends StatelessWidget {
  final BuildContext context;
  final Widget? child;
  const BaseMainBuilder({super.key, required this.context, required this.child});

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return CustomisedGreyErrorScreen(errorDetails: errorDetails);
    };
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Column(
        children: [
          Expanded(
            child: LoaderOverlay(
              useDefaultLoading: false,
              overlayColor: Colors.black.withOpacity(0.6),
              overlayWidgetBuilder: (_) {
                return const Center(
                  child: SpinKitFoldingCube(
                    color: BaseColors.secondaryColor,
                    size: 50,
                  ),
                );
              },
              child: MediaQuery(
                data: MediaQuery.of(context).scale(),
                child: child!,
              ),
            ),
          ),
          StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (BuildContext context, AsyncSnapshot<ConnectivityResult> connectivity) {
              return Visibility(
                visible: connectivity.data != null && connectivity.data != ConnectivityResult.mobile && connectivity.data != ConnectivityResult.wifi,
                child: SizedBox(
                  height: 20,
                  child: Scaffold(
                    backgroundColor: Colors.red,
                    body: Visibility(
                      visible: connectivity.data != ConnectivityResult.mobile && connectivity.data != ConnectivityResult.wifi,
                      child: Container(
                        height: 20,
                        color: (connectivity.data != ConnectivityResult.mobile && connectivity.data != ConnectivityResult.wifi) ? Colors.red : Colors.green.shade800,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: const BaseText(
                          value: "No Connection!",
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}