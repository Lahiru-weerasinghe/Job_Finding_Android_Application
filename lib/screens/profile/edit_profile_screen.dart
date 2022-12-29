import "package:flutter/material.dart";
import 'package:linkup/components/rounded_button.dart';
import 'package:linkup/components/rounded_number_field.dart';
import 'package:linkup/components/rounded_text_field.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserProvider userProvider;
  GlobalKey<FormState> editProfileFormKey = GlobalKey();
  String confirmPassword = '';

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    userProvider.modifyUser.id = userProvider.user.id;
    userProvider.modifyUser.firstName = userProvider.user.firstName;
    userProvider.modifyUser.lastName = userProvider.user.lastName;
    userProvider.modifyUser.email = userProvider.user.email;
    userProvider.modifyUser.phoneNumber = userProvider.user.phoneNumber;
  }

  void submit() {
    if (editProfileFormKey.currentState.validate()) {
      userProvider.updateUser(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontFamily: fontFamilySFPro),
        ),
        backgroundColor: colorDarkMidGround,
        elevation: 0.0,
      ),
      backgroundColor: colorDarkBackground,
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: const EdgeInsets.all(0.0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: editProfileFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedTextField(
                    text: "First Name",
                    onChange: (value) {
                      setState(() {
                        print(value);
                        userProvider.modifyUser.firstName = value;
                      });
                    },
                    value: userProvider.modifyUser.firstName,
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
                        userProvider.modifyUser.lastName = value;
                      });
                    },
                    value: userProvider.modifyUser.lastName,
                    isRequired: true,
                    backgroundColor: colorDarkBackground,
                    textAreaColor: colorDarkMidGround,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  // RoundedTextField(
                  //   text: "Email Address",
                  //   type: "email",
                  //   onChange: (value) {
                  //     setState(() {
                  //       userProvider.modifyUser.email = value;
                  //     });
                  //   },
                  //   value: userProvider.modifyUser.email,
                  //   isRequired: true,
                  //   backgroundColor: colorDarkBackground,
                  //   textAreaColor: colorDarkMidGround,
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.03,
                  // ),
                  RoundedNumberField(
                    text: "Phone Number",
                    type: "phone",
                    onChange: (value) {
                      setState(() {
                        userProvider.modifyUser.phoneNumber = value;
                      });
                    },
                    value: userProvider.modifyUser.phoneNumber,
                    isRequired: true,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedTextField(
                    text: "New Password",
                    onChange: (value) {
                      setState(() {
                        userProvider.modifyUser.password = value;
                      });
                    },
                    type: "password",
                    value: userProvider.modifyUser.password,
                    isRequired: false,
                    backgroundColor: colorDarkBackground,
                    textAreaColor: colorDarkMidGround,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedTextField(
                    text: "Confirm New Password",
                    onChange: (value) {
                      setState(() {
                        confirmPassword = value;
                      });
                    },
                    type: "password",
                    value: confirmPassword,
                    isRequired:
                        userProvider.modifyUser.password != '' ? true : false,
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
                      color: colorTextPrimary,
                      textColor: colorDarkBackground,
                      fontSize: 14,
                      height: 50,
                      width: size.width * 1,
                      text: "Save",
                      onPressed: () {
                        submit();
                      },
                    ),
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
                      color: colorErrorDark,
                      textColor: colorTextPrimary,
                      fontSize: 14,
                      height: 50,
                      width: size.width * 1,
                      text: "Delete Profile",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            backgroundColor: colorDarkMidGround,
                            title: const Text(
                              "Delete Profile",
                              style: TextStyle(
                                fontFamily: fontFamilySFPro,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: colorTextPrimary,
                              ),
                            ),
                            content: const Text(
                              "Are you sure about deleting your profile. After delete, we will completely remove your account from our system.",
                              style: TextStyle(
                                fontFamily: fontFamilySFPro,
                                fontSize: 14,
                                color: colorTextPrimary,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontFamily: fontFamilySFPro,
                                    color: colorPrimaryLight,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  userProvider.deleteUser(context);
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text(
                                  'Delete Profile',
                                  style: TextStyle(
                                    fontFamily: fontFamilySFPro,
                                    color: colorError,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
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
