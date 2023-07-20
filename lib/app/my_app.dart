import 'package:app_manteni_correc/app/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';

import 'presentation/routes/routes.dart';

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.sign_in,
      routes: appRoutes,
    );
  }
}