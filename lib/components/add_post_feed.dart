import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linkup/components/image_upload.dart';
import 'package:linkup/components/post_image_upload.dart';
import 'package:linkup/components/rounded_textarea_field.dart';
import 'package:linkup/constants.dart';
import 'package:linkup/components/rounded_button.dart';
import 'package:linkup/providers/post_provider.dart';
import 'package:linkup/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddPostFeed extends StatefulWidget {
  const AddPostFeed({
    Key key,
  }) : super(key: key);

  @override
  _AddPostFeedState createState() => _AddPostFeedState();
}

class _AddPostFeedState extends State<AddPostFeed> {
  String description = "";
  PostProvider postProvider;
  UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    postProvider = context.read<PostProvider>();
    userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: ExpansionTile(
        initiallyExpanded: false,
        collapsedBackgroundColor: colorDarkForground,
        backgroundColor: colorDarkForground,
        trailing: const Icon(
          Icons.add,
          color: colorTextPrimary,
          size: 20,
        ),
        title: const Text(
          'Create Post',
          style: TextStyle(
            fontFamily: fontFamilySFPro,
            color: colorTextPrimary,
            fontSize: 18,
          ),
        ),
        children: [
          Column(
            children: [
              Card(
                color: colorDarkForground,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 25,
                    right: 25,
                    bottom: 5,
                  ),
                  child: Column(
                    children: [
                      RoundedTextArea(
                        backgroundColor: colorDarkForground,
                        textAreaColor: colorDarkMidGround,
                        text: "Description",
                        onChange: (value) {
                          setState(() {
                            postProvider.post.description = value;
                          });
                        },
                        value: postProvider.post.description,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      PostImageUpload(
                        onFileChanged: (imageUrl) {
                          setState(() {
                            postProvider.post.postImage = imageUrl;
                          });
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      RoundedButton(
                        color: colorTextPrimary,
                        textColor: colorDarkBackground,
                        fontSize: 14,
                        height: 35,
                        width: size.width * 0.85,
                        text: "Post",
                        onPressed: () {
                          postProvider.createPost(
                            context,
                            userProvider.user.firstName,
                            userProvider.user.lastName,
                            userProvider.user.position,
                            userProvider.user.profileImageURL,
                          );
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
