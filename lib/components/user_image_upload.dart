import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkup/constants.dart';
import "package:path/path.dart" as p;
import 'package:firebase_storage/firebase_storage.dart' as storage;

class UserImageUpload extends StatefulWidget {
  final Function(String imageURL) onFileChanged;
  String imageURL;

  UserImageUpload({
    Key key,
    this.imageURL,
    this.onFileChanged,
  }) : super(key: key);

  @override
  _UserImageUploadState createState() => _UserImageUploadState();
}

class _UserImageUploadState extends State<UserImageUpload> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.imageURL == null)
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: colorDarkForground),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 150,
              color: colorDarkForground,
            ),
          ),
        if (widget.imageURL != null)
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => _selectPhoto(),
            child: AppRoundedImage.url(
              widget.imageURL,
              height: 150,
              width: 150,
            ),
          ),
        InkWell(
          onTap: () => _selectPhoto(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.imageURL != null ? "Change photo" : "Select photo",
              style: const TextStyle(
                fontFamily: fontFamilySFPro,
                color: Colors.white,
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
        ratioX: 1,
        ratioY: 1,
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

    setState(() {
      widget.imageURL = fileUrl;
    });

    widget.onFileChanged(fileUrl);
  }
}

class AppRoundedImage extends StatelessWidget {
  final ImageProvider provider;
  final double height;
  final double width;

  const AppRoundedImage(
    this.provider, {
    Key key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Image(
        image: provider,
        height: height,
        width: width,
      ),
    );
  }

  factory AppRoundedImage.url(
    String url, {
    double height,
    double width,
  }) {
    return AppRoundedImage(
      NetworkImage(url),
      height: height,
      width: width,
    );
  }

  factory AppRoundedImage.memory(
    Uint8List data, {
    double height,
    double width,
  }) {
    return AppRoundedImage(
      MemoryImage(data),
      height: height,
      width: width,
    );
  }
}
