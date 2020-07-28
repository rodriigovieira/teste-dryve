import 'package:dryve_test/interfaces/vehicles_repository.dart';
import 'package:dryve_test/models/brand.dart';
import 'package:dryve_test/models/color.dart';
import 'package:dryve_test/models/filter.dart';
import 'package:dryve_test/models/vehicle.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final IVehiclesRepository vehiclesRepository;

  final filterModel = FilterModel();

  List<VehicleModel> _listWithoutFilters = [];

  bool _loading = true;
  bool _hasError = false;

  List<VehicleModel> _vehiclesList = [];
  List<BrandModel> _brandsList = [];
  List<ColorModel> _colorsList = [];

  bool get loading => _loading;
  bool get hasError => _hasError;

  List<VehicleModel> get vehiclesList => _vehiclesList;
  List<BrandModel> get brandsList => _brandsList;
  List<ColorModel> get colorsList => _colorsList;

  HomeController({@required this.vehiclesRepository}) {
    fetchVehicles();
    fetchBrands();
    fetchColors();
  }

  void addOrRemoveBrandFromFilter(String brandId) {
    List<int> filteredBrandsIds = filterModel.brandsIds;

    bool alreadySelected = filteredBrandsIds.contains(int.parse(brandId));

    if (alreadySelected) {
      filteredBrandsIds.remove(int.parse(brandId));
    } else {
      filteredBrandsIds.add(int.parse(brandId));
    }

    notifyListeners();
  }

  void addOrRemoveColorFromFilter(String colorId) {
    List<int> filteredColorsIds = filterModel.colorsIds;

    bool alreadySelected = filteredColorsIds.contains(int.parse(colorId));

    if (alreadySelected) {
      filteredColorsIds.remove(int.parse(colorId));
    } else {
      filteredColorsIds.add(int.parse(colorId));
    }

    notifyListeners();
  }

  void filterVehicles() {
    List<int> brandsIds = filterModel.brandsIds;
    List<int> colorsIds = filterModel.colorsIds;

    if (brandsIds.isEmpty && colorsIds.isEmpty) {
      return clearFilters();
    }

    List<VehicleModel> filteredVehicles =
        _listWithoutFilters.where((VehicleModel vehicle) {
      bool userSelectedColor = colorsIds.contains(vehicle.colorId);
      bool userSelectedBrand = brandsIds.contains(vehicle.brandId);

      if (brandsIds.isEmpty) {
        return userSelectedColor;
      }

      if (colorsIds.isEmpty) {
        return userSelectedBrand;
      }

      return userSelectedBrand && userSelectedColor;
    }).toList();

    _vehiclesList = filteredVehicles;

    notifyListeners();
  }

  void clearFilters() {
    filterModel.colorsIds = [];
    filterModel.brandsIds = [];

    _vehiclesList = _listWithoutFilters;

    notifyListeners();
  }

  Future<void> fetchColors() async {
    try {
      List colors = await vehiclesRepository.getVehiclesColors();

      _colorsList = colors;
      notifyListeners();
    } catch (e) {
      handleError();
    }
  }

  Future<void> fetchBrands() async {
    try {
      List brands = await vehiclesRepository.getVehiclesBrands();

      _brandsList = brands;
      notifyListeners();
    } catch (e) {
      handleError();
    }
  }

  Future<void> fetchVehicles() async {
    _loading = true;
    _hasError = false;
    notifyListeners();

    try {
      List vehicles = await vehiclesRepository.getVehicles();
      print(vehicles);

      _vehiclesList = vehicles;
      _listWithoutFilters = vehicles;
      _loading = false;
      notifyListeners();
    } catch (e) {
      handleError();
    }
  }

  void handleError() {
    _loading = false;
    _hasError = true;
    notifyListeners();
  }
}
