import "package:flutter/material.dart";
import 'package:linkup/constants.dart';

class BookmarkedCard extends StatelessWidget {
  final String companyName;
  final String companyLogo;
  final String position;

  const BookmarkedCard({
    Key key,
    this.companyName,
    this.companyLogo,
    this.position,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  // Header section
                  children: [
                    Image.network(
                      companyLogo,
                      scale: 23,
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
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            position,
                            style: const TextStyle(
                              fontFamily: fontFamilySFPro,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
