import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shortpal/color_data.dart';
import 'package:shortpal/widgets/custom_text_widget.dart';

class AlertDialogWidget {
  static void createAlertDialog(
    BuildContext context,
    String textTitle,
    String textDescription,
    String textButton, {
    AlertType alertType = AlertType.error,
    bool isBack = true,
    bool isDoubleButton = false,
    bool isPositifContext = true,
    String? secondTextButton,
    Function? onPressed,
  }) {
    final AlertStyle alertStyle = AlertStyle(
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      titleStyle: const TextStyle(
        color: ColorData.grey52,
        fontSize: 20.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
      ),
      descStyle: const TextStyle(
        color: ColorData.grey,
        fontSize: 15.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
      ),
      backgroundColor: ColorData.white,
      animationDuration: const Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: ColorData.grey,
        ),
      ),
    );

    List<DialogButton> singleButton() {
      return [
        DialogButton(
          onPressed: isBack
              ? () {
                  Get.back();
                }
              : () {
                  onPressed!();
                },
          color: ColorData.primary,
          radius: BorderRadius.circular(8.0),
          child: CustomTextWidget(
            text: textButton,
            color: ColorData.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ];
    }

    List<DialogButton> doubleButton() {
      return [
        DialogButton(
          onPressed: () {
            onPressed!();
          },
          color: isPositifContext ? ColorData.primary : ColorData.white,
          radius: BorderRadius.circular(8.0),
          child: CustomTextWidget(
            text: textButton,
            color: isPositifContext ? ColorData.white : ColorData.grey,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        DialogButton(
          onPressed: () {
            Get.back();
          },
          color: isPositifContext ? ColorData.white : ColorData.primary,
          radius: BorderRadius.circular(8.0),
          child: CustomTextWidget(
            text: secondTextButton!,
            color: isPositifContext ? ColorData.grey : ColorData.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ];
    }

    Alert(
      context: context,
      style: alertStyle,
      type: alertType,
      title: textTitle,
      desc: textDescription,
      onWillPopActive: true,
      buttons: isDoubleButton ? doubleButton() : singleButton(),
    ).show();
  }
}
