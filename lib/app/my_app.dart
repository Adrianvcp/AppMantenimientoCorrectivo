import 'package:app_manteni_correc/app/presentation/global/app_theme.dart';
import 'package:app_manteni_correc/app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Myapp extends ConsumerWidget  {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        final appRouter = ref.watch( goRouterProvider );

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) => GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp.router(
          theme: AppTheme.defaultTheme,
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}