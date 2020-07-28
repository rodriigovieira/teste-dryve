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
            int brandsFiltered = controller.filterModel.brandsIds.length;
            int colorsFiltered = controller.filterModel.colorsIds.length;
            bool brandsAndColorsLoaded = controller.brandsList.isNotEmpty &&
                controller.colorsList.isNotEmpty;

            int quantityOfFilters = brandsFiltered + colorsFiltered;

            return Stack(
              children: [
                IconButton(
                  constraints: BoxConstraints(),
                  padding: EdgeInsets.all(4),
                  icon: Icon(Icons.tune),
                  iconSize: 28,
                  onPressed: brandsAndColorsLoaded
                      ? () => _handleFilter(context)
                      : null,
                ),
                if (quantityOfFilters > 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff0065ff),
                      ),
                      child: Center(
                        child: Text(
                          "$quantityOfFilters",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
