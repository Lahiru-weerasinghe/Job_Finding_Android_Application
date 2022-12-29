import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkup/components/rounded_button.dart';
import 'package:linkup/components/rounded_textarea_field.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/providers/post_provider.dart';
import "package:path/path.dart" as p;
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:provider/provider.dart';

class EditPost extends StatefulWidget {
  final String id;
  final String description;
  final String imageURL;

  const EditPost({
    Key key,
    this.id,
    this.description,
    this.imageURL,
  }) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  String _newImageUrl = '';
  String _newDescription = '';
  String _id = '';
  PostProvider _postProvider;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    _newDescription = widget.description;
    _newImageUrl = widget.imageURL;
    _postProvider = context.read<PostProvider>();
  }

  void submit() {
    _postProvider.updatePost(_id, _newDescription, _newImageUrl, context);
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
          "Edit Post",
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
          height: orientation == Orientation.landscape
              ? size.height * 0.95
              : size.height * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Form(
              child: Column(children: [
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
                const SizedBox(
                  height: 20,
                ),
                _PostEditImageUpload(
                  imageUrl: _newImageUrl,
                  onFileChanged: (imageUrl) {
                    setState(() {
                      _newImageUrl = imageUrl;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
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
                )
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
        if (_newImage != '')
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
