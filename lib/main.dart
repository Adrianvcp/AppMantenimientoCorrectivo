import 'package:app_manteni_correc/app/my_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

void main() async{


  runApp(
    const ProviderScope(child: Myapp() )
  );
}