import 'package:dryve_test/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorSelectCircleWidget extends StatelessWidget {
  final Color color;
  final String label;
  final String colorId;
  final bool isSelected;

  const ColorSelectCircleWidget({
    Key key,
    @required this.color,
    @required this.label,
    @required this.colorId,
    @required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller =
        Provider.of<HomeController>(context, listen: false);

    return InkWell(
      onTap: () {
        if (isSelected) {
          controller.removeColorFromFilterModel(colorId);
        } else {
          controller.addColorToFilterModel(colorId);
        }
      },
      child: Row(
        children: <Widget>[
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Color(0xff0065ff) : Color(0xffdddddd),
                width: isSelected ? 2.0 : 1.0,
              ),
              color: color,
            ),
            child: isSelected
                ? Icon(
                    Icons.check,
                    color: Color(0xff0065ff),
                    size: 16,
                  )
                : Container(),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: Color(0xff768095),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
