import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/utils/constant_data.dart';
import 'package:news_app/views/dashboard/dashboard.dart';
import 'package:news_app/widgets/my_button.dart';
import 'package:news_app/widgets/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();
  bool rememberMe = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                SvgPicture.asset(
                    width: size.width * 0.8,
                    fit: BoxFit.contain,
                    ConstantImages.loginImages),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Form(
                    key: loginFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textfields(
                            title: "Email address or Mobile",
                            size: size,
                            child: MyTextField(
                              controller: emailController,
                              hintText: "Email / Mobile",
                              maxLines: 1,
                              radius: 8,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Email address or mobile number is required";
                                } else if (!validateEmail(val) &&
                                    !validatePhone(val)) {
                                  return "Please enter valid email or mobile!";
                                }
                                return null;
                              },
                            )),
                        textfields(
                            title: "Password",
                            size: size,
                            child: MyTextField(
                              controller: passwordController,
                              hintText: "Password",
                              maxLines: 1,
                              radius: 8,
                              isObscure: true,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Password can not be empty";
                                } else if (!validatePassword(val)) {
                                  return "Your password must contain at least one uppercase letter, one symbol, and one digit.";
                                } else if (val.length < 8) {
                                  return "Password must be greater that 8 digit";
                                }
                                return null;
                              },
                            )),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Remember me next time",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Checkbox(
                          value: rememberMe,
                          side: const BorderSide(width: 1),
                          splashRadius: 0,
                          onChanged: (val) {
                            setState(() {
                              rememberMe = !rememberMe;
                            });
                          })
                    ],
                  ),
                )
              ],
            )),
            Container(
              width: size.width,
              height: 48,
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, vertical: 20),
              child: MyElevatedButton(
                  onPress: () {
                    if (loginFormKey.currentState!.validate()) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashBoard()),
                          (Route<dynamic> route) => false);
                    }
                  },
                  elevation: 0,
                  buttonContent: const Text(
                    "SIGN IN",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

Widget textfields(
    {required String title, required Widget child, required Size size}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 7),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 19, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        const SizedBox(height: 5),
        child
      ],
    ),
  );
}
