import 'package:dryve_test/pages/home/components/filter_sheet.dart';
import 'package:dryve_test/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopMenuWidget extends StatelessWidget {
  const TopMenuWidget({
    Key key,
  }) : super(key: key);

  void _handleFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        return FilterSheetWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset("assets/rectangle.png"),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            "VW Seminovos",
            style: TextStyle(
              fontFamily: "CircularStd",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff4b5670),
            ),
          ),
        ),
        Consumer<HomeController>(
          builder: (_, controller, __) {
            bool brandsAndColorsLoaded = controller.brandsList.isNotEmpty &&
                controller.colorsList.isNotEmpty;

            return IconButton(
              icon: Icon(Icons.tune),
              onPressed:
                  brandsAndColorsLoaded ? () => _handleFilter(context) : null,
            );
          },
        ),
      ],
    );
  }
}
