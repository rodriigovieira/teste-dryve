import 'package:flutter/material.dart';

class SheetTopBarWidget extends StatelessWidget {
  const SheetTopBarWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: Image.asset("assets/chevron_down.png"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: Center(
            child: Text(
              "Filtrar",
              style: TextStyle(
                color: Color(0xff1e2c4c),
                fontFamily: "CircularStd",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
