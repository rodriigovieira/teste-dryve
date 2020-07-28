import 'package:dryve_test/interfaces/http_client.dart';
import 'package:dryve_test/models/vehicle.dart';
import 'package:dryve_test/pages/home/home_controller.dart';
import 'package:dryve_test/repository/vehicles.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements IClientHttp {}

main() {
  final mock = MockClient();

  final controller = HomeController(
    vehiclesRepository: VehiclesRepository(
      client: mock,
    ),
  );

  final mockModel = VehicleModel(
    brandId: 1,
    colorId: 1,
    brandName: "AUDI",
    fuelType: "Gasolina",
    id: "1",
    imageUrl: "",
    mileage: 10000,
    modelName: "A3",
    modelYear: 2019,
    price: 80000,
    transmissionType: "Automático",
  );

  test("should fetch vehicles", () async {
    when(mock.get(VehiclesRepository.kVehiclesPathUrl)).thenAnswer((_) {
      return Future.value([mockModel.toJson()]);
    });

    await controller.fetchVehicles();

    expect(controller.vehiclesList.length, 1);
  });

  group("HomeController filters", () {
    test("should clear filters", () {
      controller.addOrRemoveColorFromFilter("0");
      controller.addOrRemoveColorFromFilter("1");
      controller.addOrRemoveColorFromFilter("2");

      controller.addOrRemoveBrandFromFilter("2");
      controller.addOrRemoveBrandFromFilter("3");

      controller.clearFilters();

      expect(controller.colorsList.length, 0);
      expect(controller.brandsList.length, 0);
    });

    test("should add and remove filters to list", () {
      final filterModel = controller.filterModel;

      // Check if IDs were added sucessfully.
      controller.addOrRemoveColorFromFilter("0");
      expect(filterModel.colorsIds.first, 0);

      controller.addOrRemoveBrandFromFilter("3");
      expect(filterModel.brandsIds.first, 3);

      // Check if IDs are removed if already in list.
      controller.addOrRemoveColorFromFilter("0");
      expect(filterModel.colorsIds.length, 0);

      controller.addOrRemoveBrandFromFilter("3");
      expect(filterModel.brandsIds.length, 0);
    });
  });
}
