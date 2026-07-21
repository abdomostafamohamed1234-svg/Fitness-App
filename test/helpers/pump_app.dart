import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {

  Future<void> pumpApp(
    Widget widget, {
    Map<String, WidgetBuilder>? routes,
  }) async {
    await pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          home: Scaffold(body: widget),
          routes: routes ?? const {},
        ),
      ),
    );
    await pump();
  }
}