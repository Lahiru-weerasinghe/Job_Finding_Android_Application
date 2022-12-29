import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linkup/components/rounded_text_field.dart';
import 'package:linkup/providers/user_provider.dart';

import '../../components/rounded_button.dart';
import '../../constants.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
  }

  void login() {
    if (userProvider.logUser.email != '' &&
        userProvider.logUser.password != '') {
      userProvider.login(context);
    } else {
      Fluttertoast.showToast(
        msg: 'Inputs are required',
        backgroundColor: colorWarningLight,
        textColor: colorDarkBackground,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: colorDarkBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: SizedBox(
            width: size.width,
            height: orientation == Orientation.landscape
                ? size.height * 0.95
                : size.height * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: orientation == Orientation.landscape
                              ? const EdgeInsets.only(left: 32, top: 10)
                              : const EdgeInsets.only(left: 10, top: 10),
                          child: const Text(
                            "Hello 👋🏻, login to your",
                            style: TextStyle(
                              fontFamily: fontFamilySFPro,
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: orientation == Orientation.landscape
                              ? const EdgeInsets.only(left: 32, top: 10)
                              : const EdgeInsets.only(left: 10, top: 10),
                          child: const Text(
                            "Privileged Club Account",
                            style: TextStyle(
                              fontFamily: fontFamilySFPro,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    RoundedTextField(
                      text: "Email Address",
                      type: "email",
                      onChange: (value) {
                        setState(() {
                          userProvider.logUser.email = value;
                        });
                      },
                      value: userProvider.logUser.email,
                      isRequired: true,
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    RoundedTextField(
                      text: "Password",
                      type: "password",
                      onChange: (value) {
                        setState(() {
                          userProvider.logUser.password = value;
                        });
                      },
                      value: userProvider.logUser.password,
                      isRequired: true,
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: RoundedButton(
                        color: colorTextPrimary,
                        textColor: colorDarkBackground,
                        fontSize: 18,
                        height: 50,
                        width: size.width * 0.4,
                        text: "Login",
                        onPressed: () {
                          login();
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SizedBox(
                      width: size.width * 0.89,
                      child: const Divider(
                        height: 2,
                        color: colorTextDisabled,
                        thickness: 2,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      width: size.width * 0.89,
                      height: size.height * 0.17,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 25,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          gradient: const LinearGradient(
                              colors: [Color(0xFF3F1320), Color(0xFFF597B3)])),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Join the Privillaged club",
                                style: TextStyle(
                                  fontFamily: fontFamilySFPro,
                                  fontSize: 20,
                                  color: colorTextPrimary,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "CREATE ACCOUNT",
                                style: TextStyle(
                                  fontFamily: fontFamilySFPro,
                                  fontSize: 28,
                                  color: colorTextPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () =>
                              {Navigator.pushNamed(context, "/signup")},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
