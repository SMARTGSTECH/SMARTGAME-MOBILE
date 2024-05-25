import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smartbet/main_screen/desktop.dart';
import 'package:smartbet/utils/config/size.dart';
import 'package:smartbet/utils/config/theme.dart';

class ISDesktop extends StatelessWidget {
  const ISDesktop({
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
      designSize: Size(screenW, screenH),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
          // ScreenUtil.defaultSize.;
          debugShowCheckedModeBanner: false,
          theme: ThemeClass.mainTheme,
          home: MainScreenDesktop()),
    );
  }
}
