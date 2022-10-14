// import 'package:flutter/material.dart';

// import 'package:get/get.dart';

// import 'app/routes/app_pages.dart';

// void main() {
//   runApp(
//     GetMaterialApp(
//       title: "Application",
//       initialRoute: AppPages.INITIAL,
//       getPages: AppPages.routes,
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:latihan_dropdown_search_api/pages/home.dart';
import 'package:latihan_dropdown_search_api/pages/village_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VillageHome(),
    );
  }
}
