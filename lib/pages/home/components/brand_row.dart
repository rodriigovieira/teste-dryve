import 'package:dryve_test/models/brand.dart';
import 'package:dryve_test/pages/home/components/filter_sheet.dart';
import 'package:dryve_test/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Map<String, String> linkToImages = {
  "1": "assets/logo_audi.png",
  "2": "assets/logo_chevrolet.png",
  "3": "assets/logo_hyundai.png",
};

class BrandRowWidget extends StatelessWidget {
  final BrandModel brand;
  final bool isSelected;

  const BrandRowWidget({
    Key key,
    @required this.brand,
    @required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller =
        Provider.of<HomeController>(context, listen: false);

    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: () {
          if (isSelected) {
            controller.removeBrandFromFilterModel(brand.brandId);
          } else {
            controller.addBrandToFilterModel(brand.brandId);
          }
        },
        child: Row(
          children: <Widget>[
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? kStrongBlueColor : Color(0xffa5abb7),
            ),
            SizedBox(width: 20),
            Image.asset(linkToImages[brand.brandId]),
            SizedBox(width: 20),
            Text(brand.name),
          ],
        ),
      ),
    );
  }
}
