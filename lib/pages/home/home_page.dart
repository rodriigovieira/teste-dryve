import 'package:dio/dio.dart';
import 'package:dryve_test/models/vehicle.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<VehicleModel> vehicles = [];

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

  Future<void> fetchVehicles() async {
    List<VehicleModel> _vehicles = [];

    const String vehicleApiUrl =
        "https://run.mocky.io/v3/e2fe4deb-f65d-45e2-b548-39c17f08e637";

    try {
      Response response = await Dio().get(vehicleApiUrl);

      print(response.data.toString());
      print(response.data);

      for (Map<String, dynamic> vehicle in response.data) {
        VehicleModel vehicleModel = VehicleModel.fromJson(vehicle);

        _vehicles.add(vehicleModel);
      }

      setState(() {
        vehicles = _vehicles;
      });
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
            ),
            child: Column(
              children: <Widget>[
                TopMenuWidget(),
                SizedBox(height: 25),
                GridView.count(
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(vehicles.length, (index) {
                    VehicleModel model = vehicles[index];

                    return GridItemWidget(model: model);
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopMenuWidget extends StatelessWidget {
  const TopMenuWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset("assets/rectangle.png"),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            "VM Seminovos",
            style: TextStyle(
              fontFamily: "CircularStd",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff4b5670),
              letterSpacing: 0.5,
            ),
          ),
        ),
        Icon(Icons.tune),
      ],
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final VehicleModel model;

  const GridItemWidget({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  model.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  Icons.favorite_border,
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
            "R\$${model.price}",
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
