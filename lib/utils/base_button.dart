import 'package:flutter/material.dart';

import 'base_color.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  double? height;
  double? width;
  final VoidCallback onPressed;
  double? radius;
  double? elevation;
  Color? btnColor;
  Color? btnTxtColor;
  Color? btnShadow;
  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamily;
  Color? borderColor;
  double? borderWidth, horizontal, vertical, horizontalMargin, verticalMargin;
  Gradient? gradient;

  CustomButton(
      {super.key,
        required this.child,
        this.height,
        this.width,
        this.radius,
        this.btnColor,
        this.fontSize,
        this.fontWeight,
        this.btnTxtColor,
        this.btnShadow,
        required this.onPressed,
        this.borderColor,
        this.borderWidth,
        this.fontFamily,
        this.vertical,
        this.horizontal,
        this.horizontalMargin,
        this.verticalMargin,
        this.gradient,
        this.elevation});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius ?? 20),
          boxShadow: [
            BoxShadow(
              color: btnShadow ?? Colors.black.withOpacity(0.2),
              offset: const Offset(0, 4), // horizontal, vertical offset
              blurRadius: 1.0,
            ),
          ],
        ),
        child: MaterialButton(
          minWidth: width,
          height: height ?? 50,
          onPressed: onPressed,
          // splashColor: Colors.black12,
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 32.0),
              side: BorderSide(color: borderColor ?? BaseColors.boarderColor, width: borderWidth ?? 1)),
          child: Ink(
            width: width ?? double.infinity,
            height: height ?? 50,
            decoration: BoxDecoration(
              gradient: gradient ??
                  const LinearGradient(
                    colors: [
                      BaseColors.secondaryColor,
                      BaseColors.primaryColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
              borderRadius: BorderRadius.circular(radius ?? 30.0),
            ),
            child: child,
          ),
        ));
  }
}