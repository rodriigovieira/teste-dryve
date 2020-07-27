import 'package:dryve_test/models/brand.dart';
import 'package:dryve_test/models/color.dart';
import 'package:dryve_test/models/filter.dart';
import 'package:dryve_test/models/vehicle.dart';

class HomeControllerModel {
  List<VehicleModel> listWithoutFilters = [];

  List<VehicleModel> vehiclesList = [];
  List<BrandModel> brandsList = [];
  List<ColorModel> colorsList = [];

  final filterModel = FilterModel();
}
