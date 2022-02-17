import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inv_app/Classes/resourceArguments.dart';
import 'package:inv_app/Views/Forms/registration.dart';
import 'package:inv_app/Views/Home/resource_details.dart';
import 'package:inv_app/Views/general.dart';
import 'package:inv_app/Views/Forms/login.dart';
import 'package:inv_app/Views/modules.dart';
import 'package:inv_app/State/filterState.dart';
import 'package:inv_app/Views/Home/homepage.dart';
import 'package:inv_app/Views/filter.dart';

void main() {
  runApp(const MyApp());
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map? queryParameters;
    int? id;
    var args;

    if (settings.name!.contains("resources?id")) {
      final uriData = Uri.parse(settings.name!);
      queryParameters = uriData.queryParameters;
      id = int.parse(queryParameters['id']);
    }
    if (settings.name == ResourceDetails.routeName) {
      args = settings.arguments as ResourceArguments;
    }

    return MaterialPageRoute(
      builder: (context) {
        return ResourceDetails(id: id != null ? id : args.id);
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.openSans().fontFamily),
      //home: GeneralStatefulWidget(),
      initialRoute: '/',
      routes: {
        '/home': (context) => GeneralStatefulWidget(),
        '/login': (context) => Login(),
        '/register': (context) => Registration(),
        '/modules': (context) => Modules(),
      },
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Login(),
    );
  }
}
