import "package:flutter/material.dart";
import 'package:linkup/constants.dart';

class RoundedNumberField extends StatefulWidget {
  final ValueChanged<String> onChange;
  final String text;
  final String type;
  final String value;
  final bool isRequired;

  const RoundedNumberField({
    Key key,
    this.text,
    this.type,
    this.value,
    this.isRequired,
    this.onChange,
  }) : super(key: key);

  @override
  _RoundedNumberFieldState createState() => _RoundedNumberFieldState();
}

class _RoundedNumberFieldState extends State<RoundedNumberField> {
  bool _isFormValid;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text(
            widget.text,
            style: const TextStyle(
              fontFamily: fontFamilyRobotoRegular,
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
        NumberFieldContainer(
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
            keyboardType: widget.type == "phone"
                ? TextInputType.phone
                : TextInputType.number,
            style: const TextStyle(
              fontFamily: fontFamilyRobotoRegular,
              fontSize: 18,
              color: Colors.white,
            ),
            onChanged: widget.onChange,
            decoration: const InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
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
    );
  }
}

class NumberFieldContainer extends StatelessWidget {
  final Widget child;

  const NumberFieldContainer({Key key, this.child}) : super(key: key);

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
        color: colorDarkMidGround,
        borderRadius: BorderRadius.circular(26),
      ),
      child: child,
    );
  }
}
