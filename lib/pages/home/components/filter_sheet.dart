import 'package:dryve_test/models/brand.dart';
import 'package:dryve_test/models/color.dart';
import 'package:dryve_test/pages/home/components/brand_row.dart';
import 'package:dryve_test/pages/home/components/color_select_circle.dart';
import 'package:dryve_test/pages/home/components/filter_sheet_button.dart';
import 'package:dryve_test/pages/home/components/sheet_top_bar.dart';
import 'package:dryve_test/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const kStrongBlueColor = Color(0xff0065ff);

Map<String, Color> linkToColors = {
  "1": Colors.white,
  "2": Colors.grey,
  "3": Colors.black,
  "4": Colors.red,
};

class FilterSheetWidget extends StatelessWidget {
  const FilterSheetWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller =
        Provider.of<HomeController>(context, listen: false);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: SafeArea(
          child: Wrap(
            children: <Widget>[
              SheetTopBarWidget(),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  "Marca",
                  style: TextStyle(
                    color: Color(0xff1e2c4c),
                    fontFamily: "CircularStd",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 25),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffd3d5dc),
                      ),
                    ),
                    hintText: "Buscar por nome...",
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 11,
                      horizontal: 16,
                    ),
                    suffixIcon: Icon(Icons.search, size: 24),
                  ),
                ),
              ),
              Consumer<HomeController>(
                builder: (_, controller, __) {
                  List<BrandModel> brandsList = controller.brandsList;

                  return Column(
                    children: <Widget>[
                      ...List.generate(brandsList.length, (index) {
                        BrandModel brand = brandsList[index];
                        List<int> brandsIds = controller.filterModel.brandsIds;

                        bool isSelected =
                            brandsIds.contains(int.parse(brand.brandId));

                        return BrandRowWidget(
                          brand: brand,
                          isSelected: isSelected,
                        );
                      }),
                    ],
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Divider(
                  color: Color(0xffdddddd),
                  thickness: 1,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Cor",
                  style: TextStyle(
                    color: Color(0xff1e2c4c),
                    fontFamily: "CircularStd",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Consumer<HomeController>(
                builder: (_, controller, __) {
                  List<ColorModel> colors = controller.colorsList;

                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 3.1,
                    children: List.generate(colors.length, (index) {
                      ColorModel color = colors[index];
                      List<int> colorsIds = controller.filterModel.colorsIds;

                      bool isSelected = colorsIds.contains(
                        int.parse(color.colorId),
                      );

                      return ColorSelectCircleWidget(
                        isSelected: isSelected,
                        color: linkToColors[color.colorId],
                        label: color.name,
                        colorId: color.colorId,
                      );
                    }),
                  );
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: FilterSheetButtonWidget(
                        onPressed: () {
                          controller.clearFilters();

                          Navigator.pop(context);
                        },
                        label: "Limpar",
                        labelColor: kStrongBlueColor,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: FilterSheetButtonWidget(
                        onPressed: () {
                          controller.filterVehicles();

                          Navigator.pop(context);
                        },
                        label: "Aplicar",
                        backgroundColor: kStrongBlueColor,
                        labelColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
