import 'package:app_manteni_correc/app/presentation/modules/sign_in/sign_in_view.dart';
import 'package:app_manteni_correc/app/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> get appRoutes{
  return {
    Routes.sign_in: (context) => const SigninView(),
  };
}