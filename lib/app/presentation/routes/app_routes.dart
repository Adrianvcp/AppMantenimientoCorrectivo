import 'package:app_manteni_correc/app/presentation/modules/home/Informe/new_informe_form.dart';
import 'package:app_manteni_correc/app/presentation/modules/home/navbar/components/drawer_view.dart';
import 'package:app_manteni_correc/app/presentation/modules/home/navbar/entrypoint.dart';
import 'package:app_manteni_correc/app/presentation/modules/sign_in/sign_in_view.dart';
import 'package:app_manteni_correc/app/presentation/modules/splash/splash_view.dart';
import 'package:app_manteni_correc/app/presentation/providers/auth/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'app_router_notifier.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      GoRoute(
        path: '/login',
        builder: (context, state) => const SignInView(),
      ),

      GoRoute(
        path: '/drawer',
        pageBuilder: (context, state) => CustomTransitionPage<void>( key: state.pageKey,child: const DrawerView(), 
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>  SlideTransition( position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
        child: child),),
        
      ),

      GoRoute(
        path: '/',
        pageBuilder: (context, state) => CustomTransitionPage<void>( key: state.pageKey,child: const EntryPointUI(), 
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>  SlideTransition( position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
        child: child),),
      ),
      
      GoRoute(
        path: '/register/:cid',
        
        pageBuilder: (context, state) => CustomTransitionPage<void>( key: state.pageKey,child: InformeScreen(
          cid: state.pathParameters['cid'] ?? 'no-cid',
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>  SlideTransition( position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
        child: child),),
      ),
    ],

    redirect: (context, state) {
      
      final isGoingTo = state.fullPath;
      final authStatus = goRouterNotifier.authStatus;

      if ( isGoingTo == '/splash' && authStatus == AuthStatus.checking ) return null;

      if ( authStatus == AuthStatus.notAuthenticated ) {
        if ( isGoingTo == '/login' ) return null;

        return '/login';
      }

      if ( authStatus == AuthStatus.authenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/splash' ){
           return '/';
        }
      }


      return null;
    },
  );
});