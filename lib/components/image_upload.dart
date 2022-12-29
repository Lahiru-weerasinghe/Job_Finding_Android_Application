import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkup/components/user_image_upload.dart';
import 'package:linkup/constants.dart';
import "package:path/path.dart" as p;
import 'package:firebase_storage/firebase_storage.dart' as storage;

class ImageUpload extends StatefulWidget {
  final Function(String imageURL) onFileChanged;

  const ImageUpload({
    Key key,
    this.onFileChanged,
  }) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  final ImagePicker _picker = ImagePicker();
  String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imagePath == null)
          Container(
            child: const Icon(
              Icons.camera,
              size: 150,
              color: colorDarkForground,
            ),
          ),
        if (imagePath != null)
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => _selectPhoto(),
            child: AppRoundedImage.url(
              imagePath,
              height: 150,
              width: 150,
            ),
          ),
        InkWell(
          onTap: () => _selectPhoto(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              imagePath != null ? "Change photo" : "Select photo",
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
    print("Test URL: " + fileUrl);

    setState(() {
      imagePath = fileUrl;
    });

    widget.onFileChanged(fileUrl);
  }
}
