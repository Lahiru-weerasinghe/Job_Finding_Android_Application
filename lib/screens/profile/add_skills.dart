import "package:flutter/material.dart";
import 'package:linkup/components/rounded_button.dart';
import 'package:linkup/components/rounded_text_field.dart';
import 'package:linkup/components/rounded_textarea_field.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../constants.dart';

class AddSkills extends StatefulWidget {
  const AddSkills({Key key}) : super(key: key);

  @override
  _AddSkillsState createState() => _AddSkillsState();
}

class _AddSkillsState extends State<AddSkills> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add skills",
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
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    RoundedTextField(
                      text: "Add Skill",
                      onChange: (value) {
                        print(value);
                      },
                      isRequired: true,
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
