import "package:flutter/material.dart";
import 'package:linkup/components/rounded_button.dart';
import 'package:linkup/constants.dart';

class ApplicationCard extends StatelessWidget {
  final String applicantName;
  final String position;
  final String profileImageURL;

  const ApplicationCard({
    Key key,
    this.applicantName,
    this.position,
    this.profileImageURL,
  }) : super(key: key);

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
          child: Card(
            color: colorDarkMidGround,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // Header section
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            profileImageURL,
                            scale: 18,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              position,
                              style: const TextStyle(
                                fontFamily: fontFamilySFPro,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              applicantName,
                              style: const TextStyle(
                                fontFamily: fontFamilySFPro,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        child: RoundedButton(
                          color: colorDarkForground,
                          fontSize: 13,
                          height: 40,
                          width: size.width * 0.2,
                          text: "View",
                          onPressed: () {
                            print("Button clicked");
                          },
                        ),
                      ),
                    ],
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
