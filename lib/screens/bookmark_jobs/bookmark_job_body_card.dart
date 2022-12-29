import "package:flutter/material.dart";
import 'package:linkup/components/rounded_button.dart';
import 'package:linkup/constants.dart';

class BookmarkedJobBodyCard extends StatelessWidget {
  final String companyName;
  final String companyLogo;
  final String postImage;
  final String position;
  final String description;
  final String salary;
  final String type;
  final String qualifications;
  final VoidCallback onClick;

  const BookmarkedJobBodyCard({
    Key key,
    this.companyName,
    this.companyLogo,
    this.postImage,
    this.position,
    this.description,
    this.salary,
    this.type,
    this.qualifications,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: orientation == Orientation.landscape
              ? size.width * 0.75
              : size.width,
          child: Card(
            elevation: 0.0,
            color: colorDarkMidGround,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (postImage != null) Image.network(postImage),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    companyName,
                    style: const TextStyle(
                      fontFamily: fontFamilySFPro,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 5,
                    right: 10,
                  ),
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontFamily: fontFamilySFPro,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    if (salary != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 5,
                          right: 10,
                        ),
                        child: Text(
                          "Salary: Rs." + salary + ".00",
                          style: const TextStyle(
                            fontFamily: fontFamilySFPro,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (type != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 5,
                          right: 10,
                        ),
                        child: Text(
                          "Job Type: " + type,
                          style: const TextStyle(
                            fontFamily: fontFamilySFPro,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 12,
                    bottom: 12,
                  ),
                  child: RoundedButton(
                    text: "Apply Now",
                    fontSize: 14,
                    color: colorDarkForground,
                    height: 32,
                    width: 95,
                    onPressed: onClick,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
