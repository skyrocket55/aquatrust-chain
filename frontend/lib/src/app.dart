import 'package:bwt_frontend/src/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BWTFrontend extends ConsumerWidget {
  const BWTFrontend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(1280, 832),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) => MaterialApp(
        title: 'BWT Frontend',
        theme: ThemeData(
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routing.onGenerateRoute,
      ),
    );
  }
}
