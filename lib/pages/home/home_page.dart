import 'package:dryve_test/models/vehicle.dart';
import 'package:dryve_test/pages/home/components/grid_item.dart';
import 'package:dryve_test/pages/home/components/top_menu.dart';
import 'package:dryve_test/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = Provider.of<HomeController>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _controller.fetchVehicles,
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
                  Consumer<HomeController>(
                    builder: (_, controller, __) {
                      List<VehicleModel> vehicles = controller.vehiclesList;

                      if (controller.hasError) {
                        return Text(
                          "Não foi possível carregar a lista de veículos nesse momento. Por favor, tente novamente mais tarde.",
                          style: TextStyle(fontSize: 16),
                        );
                      }

                      if (controller.loading) {
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      return GridView.count(
                        children: List.generate(vehicles.length, (index) {
                          VehicleModel model = vehicles[index];

                          return GridItemWidget(model: model);
                        }),
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
