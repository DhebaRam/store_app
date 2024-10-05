import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/base_button.dart';
import '../../../utils/base_color.dart';
import '../../../utils/base_functions.dart';
import '../../../utils/base_text.dart';
import '../../../utils/base_text_field.dart';
import '../../dashboard/screen/home_screen.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthController authController;
  final loginFormKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController(),
      _passwordController = TextEditingController();

  @override
  void initState() {
    if (Get.isRegistered<AuthController>()) {
      authController = Get.find<AuthController>();
    } else {
      authController = Get.put(AuthController());
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: loginFormKey,
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(height: mediaQueryHeight(context, 0.13)),
                // Center(
                //     child: Image.asset(BaseAssets.appLogo,
                //         height: 70, alignment: AlignmentDirectional.center)),
                buildSizeHeight(50.0),
                const BaseText(
                  value: 'Login',
                  color: BaseColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                buildSizeHeight(10.0),
                const BaseText(
                  value: "Hi Welcome Back You Have Been Missed",
                  color: BaseColors.textColor,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  fontSize: 14,
                ),
                buildSizeHeight(13.0),
                BaseTextField(
                  labelText: 'User Name',
                  hintText: '',
                  controller: _userNameController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validationMessage: 'Please Enter Valid UserName',
                  isName: true,
                ),
                buildSizeHeight(13.0),
                BaseTextField(
                  labelText: "Password",
                  hintText: '',
                  isPassword: true,
                  controller: _passwordController,
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
                buildSizeHeight(13.0),
                CustomButton(
                  radius: 15,
                  borderWidth: 0.1,
                  onPressed: () {
                    if (loginFormKey.currentState!.validate()) {
                      _login(context);
                    }
                  },
                  child: const Center(
                    child: BaseText(
                      value: "Login",
                      color: BaseColors.whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                buildSizeHeight(20.0),
              ],
            ).marginSymmetric(horizontal: 25))));
  }
}

extension HelperCalls on _LoginScreenState {
  void _login(context) async {
    Future.delayed(Duration.zero, () => FocusScope.of(context).unfocus());
    try {
      var map = <String, dynamic>{};
      map['username'] = _userNameController.text.trim();
      map['password'] = _passwordController.text.trim();
      await authController.loginUserMethod(context, map);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } catch (e) {

      // myCustomErrorToast(e, context);
      Navigator.pop(context);
    }
    // }
  }
}
