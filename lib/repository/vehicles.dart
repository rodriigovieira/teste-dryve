import 'package:dryve_test/interfaces/http_client.dart';
import 'package:dryve_test/interfaces/vehicles_repository.dart';
import 'package:dryve_test/models/brand.dart';
import 'package:dryve_test/models/color.dart';
import 'package:dryve_test/models/vehicle.dart';

class VehiclesRepository implements IVehiclesRepository {
  static const String kVehiclesPathUrl = "/e2fe4deb-f65d-45e2-b548-39c17f08e637";
  static const String kColorsPathUrl = "/ac466e17-58a4-432b-8647-7a2e4c4074e2";
  static const String kBrandsPathUrl = "/4f858a89-17b2-4e9c-82e0-5cdce6e90d29";
  
  VehiclesRepository({this.client});

  IClientHttp client;

  Future<List<VehicleModel>> getVehicles() async {
    List<VehicleModel> vehicles = [];

    final res = await client.get(kVehiclesPathUrl);

    for (Map<String, dynamic> vehicle in res) {
      VehicleModel vehicleModel = VehicleModel.fromJson(vehicle);

      vehicles.add(vehicleModel);
    }

    return vehicles;
  }

  Future<List<ColorModel>> getVehiclesColors() async {
    List<ColorModel> colors = [];

    final res = await client.get(kColorsPathUrl);

    for (Map<String, dynamic> color in res) {
      ColorModel colorModel = ColorModel.fromJson(color);

      colors.add(colorModel);
    }

    return colors;
  }

  Future<List<BrandModel>> getVehiclesBrands() async {
    List<BrandModel> brands = [];

    final res = await client.get(kBrandsPathUrl);

    for (Map<String, dynamic> brand in res) {
      BrandModel brandModel = BrandModel.fromJson(brand);

      brands.add(brandModel);
    }

    return brands;
  }
}
