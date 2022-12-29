import "package:flutter/material.dart";
import 'package:linkup/constants.dart';

class RoundedTextArea extends StatelessWidget {
  final ValueChanged<String> onChange;
  final Color backgroundColor;
  final Color textAreaColor;
  final String text;
  final String value;
  final String type;

  const RoundedTextArea({
    Key key,
    this.text,
    this.value,
    this.backgroundColor,
    this.textAreaColor,
    this.type,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: fontFamilySFPro,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: size.height * 0.005,
          ),
          TextFieldContainer(
            textAreaColor: textAreaColor,
            child: TextFormField(
              initialValue: value,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              minLines: 1,
              style: const TextStyle(
                fontFamily: fontFamilySFPro,
                fontSize: 18,
                color: Colors.white,
              ),
              onChanged: onChange,
              decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color textAreaColor;

  const TextFieldContainer({
    Key key,
    this.child,
    this.textAreaColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 1.5,
      ),
      width: size.width * 0.9,
      height: 120,
      decoration: BoxDecoration(
        color: textAreaColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
