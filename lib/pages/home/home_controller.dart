import 'package:dio/dio.dart';
import 'package:dryve_test/models/brand.dart';
import 'package:dryve_test/models/color.dart';
import 'package:dryve_test/models/home_controller.dart';
import 'package:dryve_test/models/vehicle.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  HomeControllerModel model = HomeControllerModel();

  List<VehicleModel> get vehiclesList => model.vehiclesList;
  List<BrandModel> get brandsList => model.brandsList;
  List<ColorModel> get colorsList => model.colorsList;

  void addBrandToFilterModel(String brandId) {
    model.filterModel.brandsIds.add(int.parse(brandId));
    notifyListeners();
  }

  void removeBrandFromFilterModel(String brandId) {
    model.filterModel.brandsIds.remove(int.parse(brandId));
    notifyListeners();
  }

  void addColorToFilterModel(String colorId) {
    model.filterModel.colorsIds.add(int.parse(colorId));
    notifyListeners();
  }

  void removeColorFromFilterModel(String colorId) {
    model.filterModel.colorsIds.remove(int.parse(colorId));
    notifyListeners();
  }

  void filterVehicles() {
    List<VehicleModel> filteredVehicles =
        model.listWithoutFilters.where((VehicleModel vehicle) {
      List<int> brandsIds = model.filterModel.brandsIds;
      List<int> colorsIds = model.filterModel.colorsIds;

      bool userSelectedColor = colorsIds.contains(vehicle.colorId);
      bool userSelectedBrand = brandsIds.contains(vehicle.brandId);

      if (brandsIds.isEmpty && colorsIds.isEmpty) {
        return true;
      }

      if (brandsIds.isEmpty) {
        return userSelectedColor;
      }

      if (colorsIds.isEmpty) {
        return userSelectedBrand;
      }

      return userSelectedBrand && userSelectedColor;
    }).toList();

    model.vehiclesList = filteredVehicles;

    notifyListeners();
  }

  void clearFilters() {
    model.vehiclesList = model.listWithoutFilters;

    notifyListeners();
  }

  Future<void> fetchColors() async {
    model.colorsList = [];

    const String colorsApiUrl =
        "https://run.mocky.io/v3/ac466e17-58a4-432b-8647-7a2e4c4074e2";

    Dio().get(colorsApiUrl).then((Response res) {
      for (Map<String, dynamic> color in res.data) {
        ColorModel colorModel = ColorModel.fromJson(color);

        model.colorsList.add(colorModel);
      }

      notifyListeners();
    }).catchError((DioError e) {});
  }

  Future<void> fetchBrands() async {
    model.brandsList = [];

    const String brandsApiUrl =
        "https://run.mocky.io/v3/4f858a89-17b2-4e9c-82e0-5cdce6e90d29";

    Dio().get(brandsApiUrl).then((Response res) {
      for (Map<String, dynamic> brand in res.data) {
        BrandModel brandModel = BrandModel.fromJson(brand);

        model.brandsList.add(brandModel);
      }

      notifyListeners();
    }).catchError((DioError e) {});
  }

  Future<void> fetchVehicles() async {
    fetchColors();
    fetchBrands();

    model.vehiclesList = [];

    const String vehicleApiUrl =
        "https://run.mocky.io/v3/e2fe4deb-f65d-45e2-b548-39c17f08e637";

    try {
      Response response = await Dio().get(vehicleApiUrl);

      for (Map<String, dynamic> vehicle in response.data) {
        VehicleModel vehicleModel = VehicleModel.fromJson(vehicle);

        model.vehiclesList.add(vehicleModel);
      }

      model.listWithoutFilters = model.vehiclesList;

      notifyListeners();
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
}
