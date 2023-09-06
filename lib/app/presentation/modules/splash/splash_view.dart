/*import 'package:app_manteni_correc/app/presentation/routes/routes.dart';
import 'package:app_manteni_correc/main.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _init();
      },
    );
  }

  Future<void> _init() async{
    final injector = Injector.of(context);
    final connectivityRepository = injector.connectivityRepository;
    final hasInternet = await connectivityRepository.hasInternet;
    print('hasInternet $hasInternet');
    if(hasInternet){
      final authenticationRepository = injector.authenticationRepository;
      final isSignedIn = await authenticationRepository.isSignedIn;
      if(isSignedIn){
        final user = await authenticationRepository.getUserData();
        if(user != null){
          _goTo(Routes.entrypoint);
        }else{
          _goTo(Routes.signIn);
        }
      }
    }else if(mounted){
      _goTo(Routes.signIn);
    } else {}
  }

  void _goTo(String routeName){
    Navigator.pushReplacementNamed(
          context, 
          routeName     
      );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';


class CheckAuthStatusScreen extends StatelessWidget {
  const CheckAuthStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}