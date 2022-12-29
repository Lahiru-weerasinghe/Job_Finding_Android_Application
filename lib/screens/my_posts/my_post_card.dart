import 'package:flutter/material.dart';
import 'package:linkup/constants.dart';
import 'package:provider/provider.dart';

class MyPostCard extends StatefulWidget {
  final String fullName;
  final String position;
  final String profileImageURL;
  final String postImage;
  final String description;

  const MyPostCard({
    Key key,
    this.fullName,
    this.position,
    this.profileImageURL,
    this.postImage,
    this.description,
  }) : super(key: key);

  @override
  _MyPostCardState createState() => _MyPostCardState();
}

class _MyPostCardState extends State<MyPostCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: orientation == Orientation.landscape
              ? size.width * 0.75
              : size.width,
          padding: const EdgeInsets.only(top: 0),
          child: Card(
            color: colorDarkMidGround,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.postImage != '') Image.network(widget.postImage),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.description,
                    style: const TextStyle(
                      fontFamily: fontFamilySFPro,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
