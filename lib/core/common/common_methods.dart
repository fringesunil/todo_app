import 'package:animate_do/animate_do.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app/core/common/colors.dart';
import 'package:todo_app/core/common/enum.dart';

mixin CommonMethods {
  back(BuildContext context) {
    Navigator.pop(context);
  }

  moveTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  void goAndCloseAll(BuildContext context, String route) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      ModalRoute.withName('/'),
    );
  }

  Flushbar flushAlert(
    BuildContext context,
    ResponseType responseType,
    String message,
  ) {
    return Flushbar(
      margin: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 10),
      padding: const EdgeInsets.all(20),
      backgroundColor: responseType == ResponseType.success
          ? Colors.greenAccent
          : responseType == ResponseType.warning
              ? Colors.orangeAccent
              : AppColors.error,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      // message: message,
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: responseType == ResponseType.success
                ? Colors.black
                : Colors.white),
      ),
      duration: const Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(10),
      // messageColor:
      //     responseType == ResponseType.success ? Colors.black : Colors.white,
      flushbarStyle: FlushbarStyle.FLOATING,
    )..show(context);
  }

  Future<void> showLoaderButton(BuildContext context,
      [String? title, bool? barrierDismissible]) async {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (BuildContext context) {
        return ElasticIn(
          child: WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: Colors.transparent,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SpinKitRing(color: AppColors.orange)
                        // SpinKitWaveSpinner(
                        //   trackColor: AppColors.lightorange,
                        //   waveColor: AppColors.orange,
                        //   color: AppColors.white,
                        //   size: 100.0,
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
