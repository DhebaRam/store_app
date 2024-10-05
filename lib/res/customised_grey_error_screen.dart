import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class CustomisedGreyErrorScreen extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const CustomisedGreyErrorScreen({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
               kDebugMode
                  ? errorDetails.summary.toString()
                  : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
            )
          ],
        ),
      ),
    );
  }
}