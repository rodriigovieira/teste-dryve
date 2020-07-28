import 'package:dryve_test/models/brand.dart';
import 'package:dryve_test/models/color.dart';
import 'package:dryve_test/models/vehicle.dart';

abstract class IVehiclesRepository {
  Future<List<VehicleModel>> getVehicles();
  Future<List<ColorModel>> getVehiclesColors();
  Future<List<BrandModel>> getVehiclesBrands();
}
