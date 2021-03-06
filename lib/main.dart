import 'package:dryve_test/pages/home/home_controller.dart';
import 'package:dryve_test/pages/home/home_page.dart';
import 'package:dryve_test/repository/vehicles.dart';
import 'package:dryve_test/services/http_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(
          create: (_) => HomeController(
            vehiclesRepository: VehiclesRepository(
              client: ClientHttpService(
                baseUrl: "https://run.mocky.io/v3",
              ),
            ),
          ),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "CircularStd",
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
