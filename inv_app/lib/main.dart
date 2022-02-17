import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inv_app/State/filterState.dart';
import 'package:inv_app/Views/Home/homepage.dart';
import 'package:inv_app/Views/filter.dart';
import 'package:inv_app/Views/general.dart';
import 'package:inv_app/Views/Forms/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FilterState(Sort.nameAZ, []),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: GoogleFonts.openSans().fontFamily),
          //home: GeneralStatefulWidget(),
          initialRoute: '/',
          routes: {
            '/': (context) => const GeneralStatefulWidget(),
            '/homepage': (context) => Homepage(),
            '/homepage/filter': (context) => FilterWidget(),
          },
        ));
  }
}
