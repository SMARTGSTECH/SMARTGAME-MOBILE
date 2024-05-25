import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smartbet/main_screen/mobile.dart';
import 'package:smartbet/main_screen/provider.dart';
import 'package:smartbet/screens/car/mobile.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/utils/config/theme.dart';

class ISMobile extends StatelessWidget {
  const ISMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SizeConfig size = SizeConfig();
    print(MediaQuery.of(context).size.width);
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.width;
    size.init(context);
    SizeConfigs().init(context);
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<MainScreenProvider>(
              create: (_) => MainScreenProvider())
        ],
        child: MaterialApp(
          // ScreenUtil.defaultSize.;
          debugShowCheckedModeBanner: false,
          theme: ThemeClass.mainTheme,
          home: MainScreenMobile(),
          routes: {
            '/carMobile': (context) =>
                CarMobileScreen(), // Route for the second screen
            // '/third': (context) => ThirdScreen(), // Route for the third screen
          },
        ),
      ),
    );
  }
}
