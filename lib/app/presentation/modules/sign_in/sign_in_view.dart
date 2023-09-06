import 'package:app_manteni_correc/app/presentation/global/app_icons.dart';
import 'package:app_manteni_correc/app/presentation/modules/sign_in/components/custom_filled_button.dart';
import 'package:app_manteni_correc/app/presentation/modules/sign_in/components/custom_text_form_field.dart';
import 'package:app_manteni_correc/app/presentation/providers/auth/auth_provider.dart';
import 'package:app_manteni_correc/app/presentation/providers/auth/login_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const Scaffold(
          backgroundColor: Color(0xFFFBFBFB),
          body: SafeArea(child: _LoginForm())
        ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void showSnackbar( BuildContext context, String message ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      if ( next.errorMessage.isEmpty ) return;
      showSnackbar( context, next.errorMessage );
    });



    return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
              padding: EdgeInsets.only(right: 30,left: 30,top: 40),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "Bienvenido!",
                  style: TextStyle(
                      color: Color(0xff1A1D1E),
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      fontSize: 30),
                ),
              ),
              ),
              const Padding(
              padding: EdgeInsets.only(left: 30,right: 30,top: 10),
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Inicia sesion con tu usuario \ny contraseña",
                    style: TextStyle(
                        color: Color(0xff6A6A6A),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        fontSize: 16),
                  ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
              child: CustomTextFormField(
              label: 'Usuario',
              icon: SvgPicture.asset(AppIcons.user),
              onChanged: ref.read(loginFormProvider.notifier).onUsernameChange,
              errorMessage: loginForm.isFormPosted ?
               loginForm.username.errorMessage 
               : null,
              ),
            ),
    
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
              child: CustomTextFormField(
              label: 'Contraseña',
              icon: SvgPicture.asset(AppIcons.pass),
              obscureText: true,
              onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
              errorMessage: loginForm.isFormPosted ?
               loginForm.password.errorMessage 
               : null,
              onFieldSubmitted: ( _ ) => ref.read(loginFormProvider.notifier).onFormSubmit(),
              
              ),
            ),
      
    
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 40,bottom: 30),
              child: SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
              text: 'Ingresar',
              buttonColor: const Color(0xfffbbb21),
              onPressed: 
                 loginForm.isPosting
                ? null 
                : ref.read(loginFormProvider.notifier).onFormSubmit
              
              )
                    ),
            ),

                ],
              ),
            ),
            /*
            const Padding(
              padding: EdgeInsets.only(right: 30,left: 30,top: 40),
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Bienvenido!",
                    style: TextStyle(
                        color: Color(0xff1A1D1E),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        fontSize: 30),
                  ),
                ),
              ),
            
            const Padding(
              padding: EdgeInsets.only(left: 30,right: 30,top: 10),
              child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Inicia sesion con tu usuario \ny contraseña",
                      style: TextStyle(
                          color: Color(0xff6A6A6A),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 16),
                    ),
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 30),
              child: CustomTextFormField(
                label: 'Usuario',
                icon: SvgPicture.asset(AppIcons.user),
                onChanged: ref.read(loginFormProvider.notifier).onUsernameChange,
                errorMessage: loginForm.isFormPosted ?
                 loginForm.username.errorMessage 
                 : null,
              ),
            ),
    
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 20),
              child: CustomTextFormField(
                label: 'Contraseña',
                icon: SvgPicture.asset(AppIcons.pass),
                obscureText: true,
                onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
                errorMessage: loginForm.isFormPosted ?
                 loginForm.password.errorMessage 
                 : null,
                onFieldSubmitted: ( _ ) => ref.read(loginFormProvider.notifier).onFormSubmit(),
                
              ),
            ),
      
    
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 40,bottom: 30),
              child: SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Ingresar',
                buttonColor: Color(0xfffbbb21),
                onPressed: 
                   loginForm.isPosting
                  ? null 
                  : ref.read(loginFormProvider.notifier).onFormSubmit
                
              )
                      ),
            ),
            */
          ],
    );
  }
}




