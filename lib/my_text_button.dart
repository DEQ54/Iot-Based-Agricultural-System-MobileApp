import 'package:flutter/material.dart';
import '../constants.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key key,
    @required this.buttonName,
    @required this.onTap,
    @required this.bgColor,
    @required this.textColor,
    @required this.focus
  }) : super(key: key);
  final String buttonName;
  final Function onTap;
  final Color bgColor;
  final Color textColor;
  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextButton(
        focusNode: focus,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => Colors.black12,
          ),
        ),
        onPressed: onTap,
        child: Text(
          buttonName,
          style: kButtonText.copyWith(color: textColor),
        ),
      ),
    );
  }
}
