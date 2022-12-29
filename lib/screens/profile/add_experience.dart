import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linkup/components/rounded_button.dart';
import 'package:linkup/components/rounded_text_field.dart';
import 'package:linkup/components/rounded_textarea_field.dart';
import 'package:linkup/providers/experience_provider.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class AddExperienceScreen extends StatefulWidget {
  const AddExperienceScreen({Key key}) : super(key: key);

  @override
  _AddExperienceScreenState createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  GlobalKey<FormState> createExp = GlobalKey();
  ExperienceProvider _expProvider;
  String _position;
  String _description;
  String _companyName;

  @override
  void initState() {
    super.initState();
    _expProvider = context.read<ExperienceProvider>();
  }

  void submit() {
    if (createExp.currentState.validate()) {
      _expProvider.addExperience(
        _position,
        _companyName,
        _description,
        context,
      );
    } else {
      Fluttertoast.showToast(msg: 'Please check the input fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add experience",
          style: TextStyle(fontFamily: fontFamilySFPro),
        ),
        backgroundColor: colorDarkMidGround,
        elevation: 0.0,
      ),
      backgroundColor: colorDarkBackground,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: orientation == Orientation.landscape
                ? size.width * 0.8
                : size.width,
            height: orientation == Orientation.landscape
                ? size.height * 1.15
                : size.height * 0.8,
            padding: const EdgeInsets.all(0.0),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Form(
                key: createExp,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    RoundedTextField(
                      text: "Title*",
                      onChange: (value) {
                        setState(() {
                          _position = value;
                        });
                      },
                      isRequired: true,
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RoundedTextField(
                      text: "Company name*",
                      onChange: (value) {
                        _companyName = value;
                      },
                      isRequired: true,
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RoundedTextArea(
                      text: "Description",
                      onChange: (value) {
                        _description = value;
                      },
                      type: "multiline",
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RoundedButton(
                        textColor: colorDarkBackground,
                        color: colorTextPrimary,
                        text: "Save",
                        width: size.width * 0.9,
                        onPressed: () {
                          submit();
                        },
                        height: 40,
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
