import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:shortpal/color_data.dart';
import 'package:shortpal/text_data.dart';

class ContainerInputWidget extends StatelessWidget {
  const ContainerInputWidget({
    required this.validator,
    required this.focusNode,
    required this.nextFocusNode,
    required this.keyboardType,
    required this.textInputAction,
    required this.onChange,
    required this.maxLength,
    Key? key,
    this.textEditingController,
    this.backgroundColor = ColorData.white,
    this.shadowColor = ColorData.grey,
    this.labelText = '',
    this.height = 80.0,
    this.width = double.infinity,
    this.fontSize = 16.0,
    this.borderRadius = 8.0,
    this.marginTop = 8.0,
    this.marginBottom = 8.0,
    this.maxLines = 1,
    this.minLines = 1,
    this.errorMaxLine = 1,
    this.isBackgroundWhite = true,
    this.isGetFocus = false,
    this.isAutofoucs = false,
    this.isReachMaxLength = false,
    this.isForceMaxLength = false,
    this.isPasswordField = false,
    this.isObsecureText = false,
    this.isSecretNumber = false,
    this.isMoney = false,
    this.isAlignLabelWithHint = false,
    this.isUnderLineBorder = false,
    this.isUsingShadow = false,
    this.isEnabled = true,
    required this.onGetFocused,
    required this.goingToReachMaxLength,
    required this.onMaxLengthReached,
    required this.onMaxLengthForced,
    required this.onFieldSubmitted,
    this.onPasswordVisibilityChange,
    required this.onSaved,
    required this.initialValue,
  }) : super(key: key);

  final String? Function(String?) validator;
  final Color backgroundColor, shadowColor;
  final FocusNode focusNode, nextFocusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? textEditingController;
  final String labelText, initialValue;
  final Function(String?) onChange, onSaved;
  final double height, width, fontSize, borderRadius, marginTop, marginBottom;
  final int maxLines, minLines, maxLength, errorMaxLine;
  final bool isBackgroundWhite,
      isGetFocus,
      isAutofoucs,
      isReachMaxLength,
      isForceMaxLength,
      isPasswordField,
      isObsecureText,
      isSecretNumber,
      isMoney,
      isAlignLabelWithHint,
      isUnderLineBorder,
      isUsingShadow,
      isEnabled;
  final VoidCallback onGetFocused,
      goingToReachMaxLength,
      onMaxLengthReached,
      onMaxLengthForced,
      onFieldSubmitted;
  final VoidCallback? onPasswordVisibilityChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: isSecretNumber
          ? const EdgeInsets.symmetric(
              horizontal: 8.0,
            )
          : EdgeInsets.only(
              top: marginTop,
              bottom: marginBottom,
            ),
      decoration: isUsingShadow
          ? BoxDecoration(
              color: !isBackgroundWhite
                  ? backgroundColor
                  : ColorData.transparent,
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: shadowColor.withOpacity(0.3),
                  blurRadius: 6.0,
                  spreadRadius: 3.0,
                ),
              ],
            )
          : BoxDecoration(
              color: !isBackgroundWhite
                  ? backgroundColor
                  : ColorData.transparent,
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
            ),
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event.runtimeType == RawKeyDownEvent) {
            if (isReachMaxLength) {
              onMaxLengthForced();
            }
          }
        },
        child: TextFormField(
          controller: textEditingController,
          onTap: onGetFocused,
          onChanged: (value) {
            onChange(value);
            if (isSecretNumber && value.length == maxLength) {
              focusNode.unfocus();
              FocusScope.of(context).requestFocus(
                nextFocusNode,
              );
            } else if (!isSecretNumber) {
              if (value.length < maxLength) {
                goingToReachMaxLength();
              } else {
                onMaxLengthReached();
              }
            }
          },
          inputFormatters: !isMoney ? [] : [ThousandsFormatter()],
          autofocus: isAutofoucs,
          onSaved: onSaved,
          textAlign: isSecretNumber ? TextAlign.center : TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          obscureText: isSecretNumber || isObsecureText,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          validator: validator,
          focusNode: focusNode,
          initialValue: initialValue,
          textInputAction: textInputAction,
          enabled: isEnabled,
          textDirection: TextDirection.ltr,
          keyboardType: keyboardType,
          onFieldSubmitted: (value) {
            if (!isSecretNumber) {
              onFieldSubmitted();
              focusNode.unfocus();
              FocusScope.of(context).requestFocus(
                nextFocusNode,
              );
            }
          },
          style: TextStyle(
            color: ColorData.grey25,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
          ),
          decoration: InputDecoration(
            suffixIcon: !isPasswordField
                ? const SizedBox.shrink()
                : IconButton(
                    icon: Icon(
                      isObsecureText ? Icons.visibility : Icons.visibility_off,
                      color: ColorData.grey52,
                    ),
                    onPressed: () {
                      onPasswordVisibilityChange!();
                    },
                  ),
            counterText: '',
            counterStyle: const TextStyle(fontSize: 0),
            errorText: isForceMaxLength
                ? '${TextData.textDescriptionWarningMaxLength} $maxLength karakter!'
                : null,
            errorMaxLines: errorMaxLine,
            alignLabelWithHint: isAlignLabelWithHint,
            contentPadding: isSecretNumber
                ? const EdgeInsets.all(5.0)
                : const EdgeInsets.all(16.0),
            labelStyle: TextStyle(
              color: isGetFocus && !isForceMaxLength
                  ? ColorData.grey52
                  : isForceMaxLength
                      ? ColorData.redEF
                      : ColorData.greyA0,
              fontSize: 12.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
            ),
            border: isUnderLineBorder
                ? const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorData.greyA0,
                    ),
                  )
                : isBackgroundWhite
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius,
                        ),
                        borderSide: const BorderSide(
                          color: ColorData.greyA0,
                        ),
                      )
                    : InputBorder.none,
            focusedBorder: isUnderLineBorder
                ? const UnderlineInputBorder()
                : isBackgroundWhite
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius,
                        ),
                      )
                    : InputBorder.none,
            labelText: isGetFocus ? '$labelText*' : labelText,
            errorBorder: isUnderLineBorder
                ? const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorData.redEF,
                    ),
                  )
                : isBackgroundWhite
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius,
                        ),
                        borderSide: const BorderSide(
                          color: ColorData.redEF,
                        ),
                      )
                    : InputBorder.none,
            focusedErrorBorder: isUnderLineBorder
                ? const UnderlineInputBorder()
                : isBackgroundWhite
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius,
                        ),
                      )
                    : InputBorder.none,
            errorStyle: isSecretNumber
                ? const TextStyle(
                    fontSize: 0,
                    color: ColorData.transparent,
                    height: 0.0,
                  )
                : const TextStyle(
                    color: ColorData.redEF,
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                  ),
          ),
        ),
      ),
    );
  }
}
