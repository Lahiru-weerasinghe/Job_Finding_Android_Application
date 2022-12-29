import "package:flutter/material.dart";
import 'package:linkup/constants.dart';

class RoundedTextField extends StatefulWidget {
  final ValueChanged<String> onChange;
  final String text;
  final String value;
  final String type;
  final bool isRequired;
  final Color backgroundColor;
  final Color textAreaColor;

  const RoundedTextField({
    Key key,
    this.onChange,
    this.text,
    this.isRequired,
    this.type,
    this.backgroundColor,
    this.textAreaColor,
    this.value,
  }) : super(key: key);

  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool _isFormValid;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: widget.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              widget.text,
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
            textAreaColor: widget.textAreaColor,
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  setState(() {
                    _isFormValid = false;
                  });
                  return null;
                } else {
                  setState(() {
                    _isFormValid = true;
                  });
                  return null;
                }
              },
              initialValue: widget.value,
              keyboardType: widget.type == "email"
                  ? TextInputType.emailAddress
                  : TextInputType.text,
              style: const TextStyle(
                fontFamily: fontFamilySFPro,
                fontSize: 18,
                color: Colors.white,
              ),
              onChanged: widget.onChange,
              decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              obscureText: widget.type == "password" ? true : false,
            ),
          ),
          if (widget.isRequired && _isFormValid != null && !_isFormValid)
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 5),
              child: Text(
                widget.text + ' is required!',
                style: const TextStyle(
                  fontFamily: fontFamilySFPro,
                  fontSize: 13,
                  color: colorError,
                ),
              ),
            ),
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
      height: 50,
      decoration: BoxDecoration(
        color: textAreaColor,
        borderRadius: BorderRadius.circular(26),
      ),
      child: child,
    );
  }
}
