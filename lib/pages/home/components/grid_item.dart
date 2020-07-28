import 'package:dryve_test/models/vehicle.dart';
import 'package:dryve_test/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GridItemWidget extends StatelessWidget {
  final VehicleModel model;

  const GridItemWidget({
    Key key,
    @required this.model,
  }) : super(key: key);

  String getPriceFormatted(int price) {
    final NumberFormat numberFormat = NumberFormat.currency(
      locale: "pt_BR",
      name: "R\$",
    );

    return numberFormat.format(price);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ShaderMask(
                  blendMode: BlendMode.darken,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ).createShader(bounds);
                  },
                  child: Image.network(
                    model.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    model.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  onPressed: () {
                    controller.addOrRemoveFromFavorites(model.id);
                  },
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Text(
                "${model.brandName} ",
                style: TextStyle(
                  fontFamily: "CircularStd",
                  color: Color(0xff4b5670),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${model.modelName}",
                style: TextStyle(
                  fontFamily: "CircularStd",
                  color: Color(0xff0065ff),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            children: <Widget>[
              Text(
                "${model.modelYear}",
                style: TextStyle(
                  fontFamily: "CircularStd",
                  color: Color(0xff768095),
                  fontSize: 14,
                ),
              ),
              Container(
                height: 3,
                width: 3,
                color: Color(0xffa5abb7),
                margin: EdgeInsets.symmetric(horizontal: 7),
              ),
              Text(
                "${model.fuelType}",
                style: TextStyle(
                  fontFamily: "CircularStd",
                  color: Color(0xff768095),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "${model.transmissionType}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "CircularStd",
                    color: Color(0xff768095),
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                height: 3,
                width: 3,
                color: Color(0xffa5abb7),
                margin: EdgeInsets.symmetric(horizontal: 6),
              ),
              Expanded(
                child: Text(
                  "${model.mileage}km",
                  style: TextStyle(
                    fontFamily: "CircularStd",
                    color: Color(0xff768095),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3),
          Text(
            getPriceFormatted(model.price),
            style: TextStyle(
              color: Color(0xff1e2c4c),
              fontSize: 16,
              fontFamily: "CircularStd",
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
