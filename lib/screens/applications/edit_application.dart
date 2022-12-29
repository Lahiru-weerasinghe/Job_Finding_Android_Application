import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linkup/components/rounded_button.dart';
import 'package:linkup/components/rounded_text_field.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/providers/application_provider.dart';
import 'package:provider/provider.dart';

class EditApplicationScreen extends StatefulWidget {
  final String applicationId;
  final String applicantName;
  final String university;
  final String nic;
  final String contactNumber;
  final String skills;
  final String languages;
  final String linkedIn;
  final String github;

  const EditApplicationScreen({
    Key key,
    this.applicationId,
    this.applicantName,
    this.university,
    this.contactNumber,
    this.github,
    this.languages,
    this.linkedIn,
    this.nic,
    this.skills,
  }) : super(key: key);

  @override
  _EditApplicationState createState() => _EditApplicationState();
}

class _EditApplicationState extends State<EditApplicationScreen> {
  GlobalKey<FormState> editApplication = GlobalKey();
  ApplicationProvider _applicationProvider;
  String _applicationId = "";
  String _applicantName = "";
  String _nic = "";
  String _contactNumber = "";
  String _university = "";
  String _skills = "";
  String _languages = "";
  String _linkedIn = "";
  String _github = "";

  @override
  void initState() {
    super.initState();
    _applicationProvider = context.read<ApplicationProvider>();
    _applicationId = widget.applicationId;
    _applicantName = widget.applicantName;
    _contactNumber = widget.contactNumber;
    _nic = widget.nic;
    _university = widget.university;
    _skills = widget.skills;
    _languages = widget.languages;
    _linkedIn = widget.linkedIn;
    _github = widget.github;
  }

  void submit() {
    if (editApplication.currentState.validate()) {
      _applicationProvider.updateApplication(
        context,
        _applicationId,
        _applicantName,
        _nic,
        _contactNumber,
        _university,
        _skills,
        _languages,
        _linkedIn,
        _github,
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
          "Edit Application",
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
            padding: const EdgeInsets.all(0.0),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Form(
                key: editApplication,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    RoundedTextField(
                      text: "Applicant Name",
                      onChange: (value) {
                        setState(() {
                          _applicantName = value;
                        });
                      },
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                      value: _applicantName,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    RoundedTextField(
                      text: "NIC",
                      onChange: (value) {
                        setState(() {
                          _nic = value;
                        });
                      },
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                      value: _nic,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    RoundedTextField(
                      text: "Contact Number",
                      type: "phone",
                      onChange: (value) {
                        setState(() {
                          _contactNumber = value;
                        });
                      },
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                      value: _contactNumber,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    RoundedTextField(
                      text: "University",
                      onChange: (value) {
                        setState(() {
                          _university = value;
                        });
                      },
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                      value: _university,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    RoundedTextField(
                      text: "Skills",
                      onChange: (value) {
                        setState(() {
                          _skills = value;
                        });
                      },
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                      value: _skills,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    RoundedTextField(
                      text: "Languages",
                      onChange: (value) {
                        setState(() {
                          _languages = value;
                        });
                      },
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                      value: _languages,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    RoundedTextField(
                      text: "LinkedIn",
                      onChange: (value) {
                        setState(() {
                          _linkedIn = value;
                        });
                      },
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                      value: _linkedIn,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    RoundedTextField(
                      text: "Github",
                      onChange: (value) {
                        setState(() {
                          _github = value;
                        });
                      },
                      backgroundColor: colorDarkBackground,
                      textAreaColor: colorDarkMidGround,
                      value: _github,
                      isRequired: true,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? SizedBox(
                            height: size.height * 0.06,
                          )
                        : SizedBox(
                            height: size.height * 0.01,
                          ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                      ),
                      child: RoundedButton(
                        color: colorTextPrimary,
                        fontSize: 16,
                        height: 45,
                        width: size.width * 0.89,
                        text: "Apply",
                        textColor: colorDarkBackground,
                        onPressed: () {
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
      ),
    );
  }
}
