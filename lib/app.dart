import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:toolu_fatima/utils/constants/colors.dart';
import 'package:toolu_fatima/utils/theme/theme.dart';

import 'bindings/general_bindings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: Scaffold(
        backgroundColor: MyColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: MyColors.white,
          ),
        ),
      ),
    );
  }
}
