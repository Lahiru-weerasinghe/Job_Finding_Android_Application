import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkup/components/rounded_button.dart';
import 'package:linkup/components/rounded_text_field.dart';
import 'package:linkup/components/rounded_textarea_field.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/providers/job_provider.dart';
import "package:path/path.dart" as p;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:provider/provider.dart';

class EditJob extends StatefulWidget {
  final String id;
  final String companyLogo;
  final String jobImage;
  final String description;
  final String position;
  final String salary;
  final String companyName;

  const EditJob({
    Key key,
    this.id,
    this.companyLogo,
    this.jobImage,
    this.description,
    this.position,
    this.salary,
    this.companyName,
  }) : super(key: key);

  @override
  _EditJobState createState() => _EditJobState();
}

class _EditJobState extends State<EditJob> {
  String _newCompanyLogo = '';
  String _newJobImage = '';
  String _newDescription = '';
  String _newPosition = '';
  String _newSalary = '';
  String _newCompanyName = '';
  String _id = '';
  JobProvider _jobProvider;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    _newCompanyLogo = widget.companyLogo;
    _newJobImage = widget.jobImage;
    _newPosition = widget.position;
    _newSalary = widget.salary;
    _newCompanyName = widget.companyName;
    _newDescription = widget.description;
    _jobProvider = context.read<JobProvider>();
  }

  void submit() {
    _jobProvider.updateJob(_id, _newCompanyLogo, _newJobImage,_newDescription, _newPosition,
        _newSalary, _newCompanyName, context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDarkBackground,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: const Text(
          "Edit Job",
          style: TextStyle(
            fontFamily: "SF-Pro",
            color: colorTextPrimary,
          ),
        ),
      ),
      backgroundColor: colorDarkBackground,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Form(
              child: Column(children: [
                RoundedTextField(
                  text: "Company Name",
                  value: _newCompanyName,
                  onChange: (value) {
                    setState(() {
                      _newCompanyName = value;
                    });
                  },
                  isRequired: true,
                  backgroundColor: colorDarkBackground,
                  textAreaColor: colorDarkMidGround,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Text(
                  'Company logo',
                  style: TextStyle(
                    color: colorTextPrimary,
                    fontFamily: fontFamilySFPro,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                _PostEditImageUpload(
                  imageUrl: _newCompanyLogo,
                  onFileChanged: (imageUrl) {
                    setState(() {
                      _newCompanyLogo = imageUrl;
                    });
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RoundedTextField(
                  text: "Position",
                  value: _newPosition,
                  onChange: (value) {
                    setState(() {
                      _newPosition = value;
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
                  text: "Salary",
                  value: _newSalary,
                  onChange: (value) {
                    setState(() {
                      _newSalary = value;
                    });
                  },
                  isRequired: true,
                  backgroundColor: colorDarkBackground,
                  textAreaColor: colorDarkMidGround,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RoundedTextArea(
                  backgroundColor: colorDarkBackground,
                  textAreaColor: colorDarkMidGround,
                  text: 'Description',
                  value: _newDescription,
                  onChange: (value) {
                    setState(() {
                      _newDescription = value;
                    });
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Job post image',
                      style: TextStyle(
                        color: colorTextPrimary,
                        fontFamily: fontFamilySFPro,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                _PostEditImageUpload(
                  imageUrl: _newJobImage,
                  onFileChanged: (imageUrl) {
                    setState(() {
                      _newJobImage = imageUrl;
                    });
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                RoundedButton(
                  color: colorTextPrimary,
                  textColor: colorDarkBackground,
                  fontSize: 16,
                  height: 45,
                  width: size.width * 0.92,
                  text: 'Save',
                  onPressed: () {
                    submit();
                  },
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _PostEditImageUpload extends StatefulWidget {
  final Function(String imageURL) onFileChanged;
  String imageUrl;

  _PostEditImageUpload({
    Key key,
    this.imageUrl,
    this.onFileChanged,
  }) : super(key: key);

  @override
  _PostImageUploadState createState() => _PostImageUploadState();
}

class _PostImageUploadState extends State<_PostEditImageUpload> {
  final ImagePicker _picker = ImagePicker();
  String _newImage = '';

  @override
  void initState() {
    super.initState();
    _newImage = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        if (_newImage != '')
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => _selectPhoto(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                _newImage,
                width: size.width * 0.89,
              ),
            ),
          ),
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: colorDarkMidGround,
              ),
              child: InkWell(
                onTap: () => _selectPhoto(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.image,
                        size: 18,
                        color: colorTextPrimary,
                      ),
                      Text(
                        widget.imageUrl != null
                            ? " Change photo"
                            : " Select photo",
                        style: const TextStyle(
                          fontFamily: fontFamilySFPro,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future _selectPhoto() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text(
                "Camera",
                style: TextStyle(
                  fontFamily: fontFamilySFPro,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              horizontalTitleGap: 0,
              leading: const Icon(Icons.folder_outlined),
              title: const Text(
                "Pick a photo",
                style: TextStyle(
                  fontFamily: fontFamilySFPro,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
        onClosing: () {},
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    final pickerFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickerFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(
      sourcePath: pickerFile.path,
      aspectRatio: const CropAspectRatio(
        ratioX: 16,
        ratioY: 9,
      ),
    );
    if (file == null) {
      return;
    }

    await _uploadFile(file.path);
  }

  Future _uploadFile(String path) async {
    await Firebase.initializeApp();
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child("images")
        .child(DateTime.now().toIso8601String() + p.basename(path));

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();
    print("Test URL: " + fileUrl);

    setState(() {
      _newImage = fileUrl;
    });

    widget.onFileChanged(fileUrl);
  }
}
