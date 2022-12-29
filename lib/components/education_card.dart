import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkup/constants.dart';

class EducationCard extends StatelessWidget {
  final String educationLogo;
  final String period;
  final String schoolName;
  final String course;

  const EducationCard({
    Key key,
    this.educationLogo,
    this.schoolName,
    this.period,
    this.course,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      width: size.width,
      padding: const EdgeInsets.only(top: 15, left: 5),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.userGraduate,
                color: colorTextPrimary,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course,
                      style: const TextStyle(
                        fontFamily: fontFamilySFPro,
                        fontSize: 19,
                        color: colorTextPrimary,
                      ),
                    ),
                    Text(
                      schoolName,
                      style: const TextStyle(
                        fontFamily: fontFamilySFPro,
                        fontSize: 16,
                        color: colorTextPrimary,
                      ),
                    ),
                    Text(
                      period,
                      style: const TextStyle(
                        fontFamily: fontFamilySFPro,
                        fontSize: 13,
                        color: colorTextPrimary,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
