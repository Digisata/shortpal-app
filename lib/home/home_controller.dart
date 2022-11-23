import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shortpal/api_service.dart';
import 'package:shortpal/constant_data.dart';
import 'package:shortpal/helpers/check_connectivity_helper.dart';
import 'package:shortpal/home/teddy_controller.dart';
import 'package:shortpal/text_data.dart';
import 'package:shortpal/url_model.dart';
import 'package:shortpal/widgets/alert_dialog_widget.dart';

class HomeController extends GetxController {
  final TeddyController teddyController = TeddyController();
  final CheckConnectivityHelper _checkConnectivityHelper =
      CheckConnectivityHelper();
  final ApiService _apiService = ApiService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode originUrlInputFocus = FocusNode(), resultFocus = FocusNode();
  late UrlModel urlModel;
  String inputOriginUrl = '', result = '';
  bool isAutoValidate = false,
      isHomeLoading = false,
      isCopyButtonClicked = false,
      isOriginUrlGetFocus = false,
      isOriginUrlReachMaxLength = false,
      isOriginUrlForceMaxLength = false;

  void setIsOriginUrlGetFocus(bool isOriginUrlGetFocus) {
    this.isOriginUrlGetFocus = isOriginUrlGetFocus;
    update();
  }

  void setIsOriginUrlReachMaxLength(bool isOriginUrlReachMaxLength) {
    this.isOriginUrlReachMaxLength = isOriginUrlReachMaxLength;
    update();
  }

  void setIsOriginUrlForceMaxLength(bool isOriginUrlForceMaxLength) {
    this.isOriginUrlForceMaxLength = isOriginUrlForceMaxLength;
    update();
  }

  void setIsAutoValidate(bool isAutoValidate) {
    this.isAutoValidate = isAutoValidate;
    update();
  }

  void _setIsHomeLoading(bool isHomeLoading) {
    this.isHomeLoading = isHomeLoading;
    update([ConstantData.homeId]);
  }

  void _setIsCopyButtonClicked(bool isCopyButtonClicked) {
    this.isCopyButtonClicked = isCopyButtonClicked;
    update([ConstantData.copyId]);
  }

  void shortUrl(BuildContext context) {
    _setIsHomeLoading(true);
    _checkConnectivityHelper.checkConnectivity().then(
      (value) {
        if (value) {
          final Map<String, dynamic> body = {
            'url': inputOriginUrl,
          };

          _apiService.shortUrl(body).then(
            (value) {
              if (value is UrlModel) {
                urlModel = value;
                result = urlModel.url.shortUrl;
                _setIsHomeLoading(false);
              } else {
                _setIsHomeLoading(false);
                AlertDialogWidget.createAlertDialog(
                  context,
                  TextData.textSorry,
                  value.toString(),
                  TextData.textOk,
                );
              }
            },
          );
        } else {
          _setIsHomeLoading(false);
          AlertDialogWidget.createAlertDialog(
            context,
            TextData.textWarning,
            TextData.textNoInternet,
            TextData.textOk,
            alertType: AlertType.warning,
          );
        }
      },
    );
  }

  void copyLink() async {
    await Clipboard.setData(ClipboardData(text: result));
    _setIsCopyButtonClicked(true);
    Future.delayed(const Duration(seconds: 1), () {
      _setIsCopyButtonClicked(false);
    });
  }
}
