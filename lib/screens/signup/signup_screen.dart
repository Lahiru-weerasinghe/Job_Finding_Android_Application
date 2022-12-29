import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linkup/components/rounded_button.dart';
import 'package:linkup/components/rounded_number_field.dart';
import 'package:linkup/components/rounded_text_field.dart';
import 'package:linkup/components/side_navbar.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../components/user_image_upload.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  UserProvider userProvider;
  GlobalKey<FormState> createProfileFormKey = GlobalKey();
  String conformPassword;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
  }

  void submit() {
    if (createProfileFormKey.currentState.validate()) {
      if (userProvider.newUser.password == conformPassword) {
        userProvider.create(context);
      } else {
        Fluttertoast.showToast(
          msg: 'Password not matched',
          backgroundColor: colorWarningLight,
          textColor: colorDarkBackground,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDarkBackground,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            fontFamily: "SF-Pro",
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: colorDarkBackground,
      // drawer: const SideNavbar(),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: const EdgeInsets.all(0.0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: createProfileFormKey,
              child: Column(
                children: [
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "We warmly welcomey you to LinkUp",
                          style: TextStyle(
                            fontFamily: fontFamilySFPro,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  UserImageUpload(
                    onFileChanged: (imageUrl) {
                      print('Test: ' + imageUrl);
                      userProvider.newUser.profileImageURL = imageUrl;
                    },
                    imageURL: userProvider.newUser.profileImageURL,
                  ),
                  RoundedTextField(
                    text: "First Name",
                    onChange: (value) {
                      setState(() {
                        userProvider.newUser.firstName = value;
                      });
                    },
                    isRequired: true,
                    backgroundColor: colorDarkBackground,
                    textAreaColor: colorDarkMidGround,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedTextField(
                    text: "Last Name",
                    onChange: (value) {
                      setState(() {
                        userProvider.newUser.lastName = value;
                      });
                    },
                    isRequired: true,
                    backgroundColor: colorDarkBackground,
                    textAreaColor: colorDarkMidGround,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedTextField(
                    text: "Email Address",
                    type: "email",
                    onChange: (value) {
                      setState(() {
                        userProvider.newUser.email = value;
                      });
                    },
                    isRequired: true,
                    backgroundColor: colorDarkBackground,
                    textAreaColor: colorDarkMidGround,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedNumberField(
                    text: "Phone Number",
                    type: "phone",
                    onChange: (value) {
                      setState(() {
                        userProvider.newUser.phoneNumber = value;
                      });
                    },
                    isRequired: true,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedTextField(
                    text: "Position",
                    onChange: (value) {
                      setState(() {
                        userProvider.newUser.position = value;
                      });
                    },
                    isRequired: true,
                    backgroundColor: colorDarkBackground,
                    textAreaColor: colorDarkMidGround,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedTextField(
                    text: "Password",
                    onChange: (value) {
                      setState(() {
                        userProvider.newUser.password = value;
                      });
                    },
                    type: "password",
                    isRequired: true,
                    backgroundColor: colorDarkBackground,
                    textAreaColor: colorDarkMidGround,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedTextField(
                    text: "Conform Password",
                    onChange: (value) {
                      setState(() {
                        conformPassword = value;
                      });
                    },
                    type: "password",
                    isRequired: true,
                    backgroundColor: colorDarkBackground,
                    textAreaColor: colorDarkMidGround,
                  ),
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? SizedBox(
                          height: size.height * 0.06,
                        )
                      : SizedBox(
                          height: size.height * 0.03,
                        ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: RoundedButton(
                      color: colorDarkForground,
                      fontSize: 14,
                      height: 50,
                      width: size.width * 0.4,
                      text: "Sign Up",
                      onPressed: () {
                        print("Button clicked");
                        submit();
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
