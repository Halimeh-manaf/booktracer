import 'package:booktracer/widget/title_with_custom_underline.dart';
import 'package:flutter/material.dart';

class TitleWithAddBtn extends StatelessWidget {
  const TitleWithAddBtn({
    Key key,
    this.title,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          TitleWithCustomUnderline(title: "Notes"),
          Spacer(),
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              )),
            ),
            onPressed: onPressed,
            child: Text(title),
          )
        ],
      ),
    );
  }
}
