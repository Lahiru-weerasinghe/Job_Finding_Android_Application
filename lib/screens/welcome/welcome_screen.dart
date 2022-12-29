import "package:flutter/material.dart";
import 'package:linkup/constants.dart';
import 'package:linkup/providers/post_provider.dart';
import 'package:linkup/providers/user_provider.dart';
import 'package:linkup/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  final Widget navigationPage;
  final int duration;

  const WelcomeScreen({
    Key key,
    this.duration,
    this.navigationPage,
  }) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _authToken;

  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().getProfile(context);
    context.read<UserProvider>().storage.read(key: 'userId').then((value) {
      setState(() {
        _authToken = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Page navigation
    Future.delayed(Duration(seconds: widget.duration), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>
              _authToken != null ? widget.navigationPage : const LoginScreen(),
        ),
        (route) => false,
      );
    });

    return Scaffold(
      backgroundColor: colorDarkBackground,
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/link_up_logo.png',
                  height: 150,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Earn Your Job Today",
                style: TextStyle(
                  fontFamily: fontFamilyRobotoRegular,
                  fontSize: 18,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
