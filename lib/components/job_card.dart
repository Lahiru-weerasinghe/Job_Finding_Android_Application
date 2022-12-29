import "package:flutter/material.dart";
import 'package:linkup/components/rounded_button.dart';
import 'package:linkup/constants.dart';

class JobCard extends StatelessWidget {
  final String companyName;
  final String companyLogo;
  final String jobImage;
  final String position;
  final String description;
  final String salary;
  final VoidCallback onClick;
  final bool isPublic;

  const JobCard({
    Key key,
    this.companyName,
    this.companyLogo,
    this.jobImage,
    this.position,
    this.description,
    this.salary,
    this.onClick,
    this.isPublic,
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
          padding: const EdgeInsets.only(top: 5, bottom: 0),
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
                          companyLogo,
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              companyName,
                              style: const TextStyle(
                                fontFamily: fontFamilySFPro,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: colorTextPrimary,
                              ),
                            ),
                            Text(
                              position,
                              style: const TextStyle(
                                fontFamily: fontFamilySFPro,
                                fontSize: 14,
                                color: colorTextPrimary,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                if (jobImage != '') Image.network(jobImage),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
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
                    if (salary != '')
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 12,
                    bottom: 12,
                  ),
                  child: isPublic
                      ? RoundedButton(
                          text: "Apply Now",
                          fontSize: 14,
                          textColor: colorDarkBackground,
                          color: colorTextPrimary,
                          height: 32,
                          width: 95,
                          onPressed: onClick,
                        )
                      : const SizedBox(),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
