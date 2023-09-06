import 'package:app_manteni_correc/app/presentation/global/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogStatusCustom {
  Widget succesfull(context, String _title) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: 375,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
              child: Icon(
                Icons.check_circle_rounded,
                color: AppColors.kColorPrimary,
                size: 117,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 11),
                  height: 44,
                  width: 128,
                  decoration: BoxDecoration(
                    color: AppColors.kBottomColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      hideLoading(context);
                    },
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context, false);
  }

  Widget error(context, String title) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: 375,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
              child: Icon(
                Icons.error_sharp,
                color: Colors.red,
                size: 117,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 11),
                  height: 44,
                  width: 128,
                  decoration: BoxDecoration(
                    color: AppColors.kBottomColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      hideLoading(context);
                    },
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void showDialogLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: ()  async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            contentPadding: EdgeInsets.only(top: 10.0.h),
            content: Container(
              width: 375.0.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Cargando...",
                        style: TextStyle(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 40.w,
                          height: 40.h,
                          child: CircularProgressIndicator())
                    ],
                  ),
                  SizedBox(height: 20.0.h),
        
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<Widget> validationLoading() =>
      Future.delayed(Duration(seconds: 3), () => Text("Termino"));

  static Future<Widget> wait() =>
      Future.delayed(Duration(seconds: 1), () => Text(""));


  Widget errorLogin(context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: 375,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Datos incorrectos",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 5.0, bottom: 5.0),
              child: Icon(
                Icons.error_sharp,
                color: AppColors.kColorPrimary,
                size: 88,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 11),
                  height: 44,
                  width: 128,
                  decoration: BoxDecoration(
                    color: AppColors.kBottomColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      hideLoading(context);
                    },
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // static void showActivateGPS(context, Function ){
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('GPS Desactivado'),
  //           content: Text('Por favor, activa el GPS para continuar.'),
  //           actions: <Widget>[
  //             TextButton(
  //               child: Text('Cancelar'),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             TextButton(
  //               child: Text('Activar GPS'),
  //               onPressed: () {
  //                 Geolocator.openLocationSettings();
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  // }
  static Widget fullScreenLoading(){
    return const SizedBox.expand(
      child: Center(
        child: CircularProgressIndicator( strokeWidth: 2),
      ));
  }
}
