import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortpal/color_data.dart';
import 'package:shortpal/constant_data.dart';
import 'package:shortpal/helpers/url_launcher_helper.dart';
import 'package:shortpal/helpers/validator_helper.dart';
import 'package:shortpal/home/home_controller.dart';
import 'package:shortpal/home/primary_button.dart';
import 'package:shortpal/text_data.dart';
import 'package:shortpal/widgets/alert_dialog_widget.dart';
import 'package:shortpal/widgets/container_input_widget.dart';
import 'package:shortpal/widgets/custom_text_widget.dart';

class HomeRoute extends StatelessWidget {
  final ValidatorHelper _validatorHelper = ValidatorHelper();
  final UrlLauncherHelper _urlLauncherHelper = UrlLauncherHelper();

  HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetBuilder<HomeController> originUrlField =
        GetBuilder<HomeController>(
      builder: (homeController) => ContainerInputWidget(
        validator: _validatorHelper.validateBasic,
        initialValue: homeController.inputOriginUrl,
        focusNode: homeController.originUrlInputFocus,
        nextFocusNode: FocusNode(),
        keyboardType: TextInputType.text,
        maxLength: 1000,
        textInputAction: TextInputAction.done,
        labelText: TextData.textHintOriginUrl,
        onGetFocused: () {
          homeController.setIsOriginUrlGetFocus(true);
        },
        goingToReachMaxLength: () {
          homeController.setIsOriginUrlReachMaxLength(false);
          homeController.setIsOriginUrlForceMaxLength(false);
        },
        onMaxLengthReached: () {
          homeController.setIsOriginUrlReachMaxLength(true);
        },
        onMaxLengthForced: () {
          homeController.setIsOriginUrlForceMaxLength(true);
        },
        onFieldSubmitted: () {
          homeController.setIsOriginUrlGetFocus(false);
          homeController.setIsOriginUrlForceMaxLength(false);
        },
        onSaved: (String? value) {
          homeController.inputOriginUrl = value!.trim();
          homeController.setIsOriginUrlForceMaxLength(false);
        },
        onChange: (String? value) {
          homeController.inputOriginUrl = value!.trim();
        },
        isUnderLineBorder: true,
        marginTop: 0.0,
        marginBottom: 16.0,
        isGetFocus: homeController.isOriginUrlGetFocus,
        isReachMaxLength: homeController.isOriginUrlReachMaxLength,
        isForceMaxLength: homeController.isOriginUrlForceMaxLength,
      ),
    );

    return GetBuilder<HomeController>(
      id: ConstantData.homeId,
      builder: (homeController) => WillPopScope(
        onWillPop: homeController.isHomeLoading
            ? () async => false
            : () async {
                FocusScope.of(context).requestFocus(
                  FocusNode(),
                );
                return true;
              },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(
              FocusNode(),
            );
          },
          child: Scaffold(
            backgroundColor: const Color.fromRGBO(93, 142, 155, 1.0),
            body: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      // Box decoration takes a gradient
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        stops: [0.0, 1.0],
                        colors: [
                          Color.fromRGBO(170, 207, 211, 1.0),
                          Color.fromRGBO(93, 142, 155, 1.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        left: Adaptive.w(5),
                        right: Adaptive.w(5),
                        top: Adaptive.w(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 30.h,
                          padding: EdgeInsets.only(
                              left: Adaptive.w(5), right: Adaptive.w(5)),
                          child: FlareActor(
                            "assets/Teddy.flr",
                            shouldClip: false,
                            alignment: Alignment.bottomCenter,
                            fit: BoxFit.contain,
                            controller: homeController.teddyController,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(Adaptive.w(2)),
                            child: Form(
                              key: homeController.formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  originUrlField,
                                  homeController.result.isEmpty ||
                                          homeController.isHomeLoading
                                      ? const SizedBox.shrink()
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: Adaptive.h(1),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: Adaptive.w(1),
                                                ),
                                                child: MouseRegion(
                                                  cursor:
                                                      SystemMouseCursors.click,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      await _urlLauncherHelper
                                                          .launchWebView(
                                                              homeController
                                                                  .result);
                                                    },
                                                    child: CustomTextWidget(
                                                      text:
                                                          homeController.result,
                                                      color: ColorData.blue,
                                                      fontSize: 16.0,
                                                      fontFamily:
                                                          'RobotoMedium',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GetBuilder<HomeController>(
                                                id: ConstantData.copyId,
                                                builder: (homeController) =>
                                                    PrimaryButton(
                                                  width: Adaptive.w(10),
                                                  onPressed: homeController
                                                          .isCopyButtonClicked
                                                      ? () {}
                                                      : () {
                                                          homeController
                                                              .copyLink();
                                                        },
                                                  colors: homeController
                                                          .isCopyButtonClicked
                                                      ? const [
                                                          Color.fromARGB(255,
                                                              92, 160, 109),
                                                          Color.fromARGB(
                                                              255, 82, 135, 108)
                                                        ]
                                                      : const [
                                                          Color.fromRGBO(160,
                                                              92, 147, 1.0),
                                                          Color.fromRGBO(
                                                              115, 82, 135, 1.0)
                                                        ],
                                                  child: CustomTextWidget(
                                                    text: homeController
                                                            .isCopyButtonClicked
                                                        ? TextData.textCopied
                                                        : TextData.textCopy,
                                                    color: ColorData.white,
                                                    fontSize: 16.0,
                                                    fontFamily: 'RobotoMedium',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  PrimaryButton(
                                    onPressed: homeController.isHomeLoading
                                        ? () {}
                                        : () {
                                            if (homeController
                                                .formKey.currentState!
                                                .validate()) {
                                              homeController
                                                  .formKey.currentState!
                                                  .save();
                                              homeController.shortUrl(context);
                                            } else {
                                              homeController
                                                  .setIsAutoValidate(true);
                                              AlertDialogWidget
                                                  .createAlertDialog(
                                                context,
                                                TextData.textSorry,
                                                TextData
                                                    .textDescriptionWarningUncomplete,
                                                TextData.textOk,
                                              );
                                            }
                                          },
                                    colors: const [
                                      Color.fromRGBO(160, 92, 147, 1.0),
                                      Color.fromRGBO(115, 82, 135, 1.0)
                                    ],
                                    width: Adaptive.w(1000),
                                    child: const CustomTextWidget(
                                      text: TextData.textShort,
                                      color: ColorData.white,
                                      fontSize: 16.0,
                                      fontFamily: 'RobotoMedium',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
