import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_images.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

import '../text/label_text_with_instructions.dart';

class CustomTextField extends StatefulWidget {
  final String? instructions;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final VoidCallback? onTap;
  final bool isSearch;
  final bool isCountryPicker;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool readOnly;
  final bool showShadow;
  final bool needRequiredSign;
  final int? maxLines;
  final int? maxlength;
  final bool animatedLabel;
  final bool isPhone;
  final Color fillColor;
  final Color borderColor;
  final bool isRequired;
  final Widget? suffixIcon;
  final bool? suffixImage;
  final Widget? suffixWidget;
  final Widget? prefixIcon;

  const CustomTextField({
    super.key,
    this.instructions,
    this.labelText,
    this.readOnly = false,
    this.fillColor = MyColor.lightTextFieldBackground,
    this.borderColor = MyColor.lightTextFieldBorder,
    required this.onChanged,
    this.hintText,
    this.showShadow = false,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isShowSuffixIcon = false,
    this.isIcon = false,
    this.onSuffixTap,
    this.isSearch = false,
    this.isCountryPicker = false,
    this.inputAction = TextInputAction.next,
    this.needOutlineBorder = false,
    this.needRequiredSign = false,
    this.maxLines,
    this.maxlength,
    this.animatedLabel = false,
    this.isRequired = false,
    this.onTap,
    this.initialValue,
    this.suffixIcon,
    this.prefixIcon,
    this.isPhone = false,
    this.suffixWidget,
    this.suffixImage,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isPhone) ...[],
        widget.labelText != null
            ? LabelTextInstruction(
                text: widget.labelText.toString(),
                isRequired: widget.isRequired,
                instructions: widget.instructions,
              )
            : SizedBox.shrink(),
        const SizedBox(height: Dimensions.textToTextSpace),
        widget.showShadow
            ? CustomAppCard(
                padding: EdgeInsets.zero,
                showShadow: true,
                showBorder: false,
                boxShadow: [
                  BoxShadow(
                    color: MyColor.black.withValues(alpha: .20),
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(widget.maxlength),
                  ],
                  maxLines: widget.maxLines ?? 1,
                  readOnly: widget.readOnly,
                  style: regularDefault.copyWith(color: MyColor.headingTextColor),
                  //textAlign: TextAlign.left,
                  cursorColor: MyColor.getBodyTextColor(),
                  controller: widget.controller,
                  autofocus: false,
                  textInputAction: widget.inputAction,
                  enabled: widget.isEnable,
                  focusNode: widget.focusNode,
                  validator: widget.validator,
                  keyboardType: widget.textInputType,

                  obscureText: widget.isPassword ? obscureText : false,
                  initialValue: widget.initialValue,
                  decoration: InputDecoration(
                    labelStyle: regularDefault.copyWith(color: MyColor.headingTextColor),
                    contentPadding: EdgeInsetsDirectional.symmetric(vertical: Dimensions.space12.w, horizontal: Dimensions.space10.h),
                    hintText: widget.hintText != null ? widget.hintText!.tr : '',
                    hintStyle: regularLarge.copyWith(color: MyColor.hintTextColor),
                    fillColor: widget.fillColor,
                    filled: true,
                    border: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: widget.borderColor), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: widget.borderColor), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: widget.borderColor), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.isShowSuffixIcon
                        ? widget.isPassword
                            ? GestureDetector(
                                onTap: _toggle,
                                child: Padding(
                                  padding: const EdgeInsets.all(Dimensions.space10),
                                  child: MyAssetImageWidget(
                                    assetPath: obscureText ? MyImages.eyeInvisibleIcon : MyImages.eyeVisibleIcon,
                                    height: Dimensions.space24.h,
                                    width: Dimensions.space24.h,
                                    boxFit: BoxFit.contain,
                                    color: MyColor.hintTextColor,
                                    isSvg: true,
                                  ),
                                ))
                            : widget.isIcon
                                ? IconButton(
                                    onPressed: widget.onSuffixTap,
                                    icon: Icon(
                                      widget.isSearch
                                          ? Icons.search_outlined
                                          : widget.isCountryPicker
                                              ? Icons.arrow_drop_down_outlined
                                              : Icons.camera_alt_outlined,
                                      size: 25,
                                      color: MyColor.getPrimaryColor(),
                                    ),
                                  )
                                : null
                        : null,
                  ),
                  onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                  onChanged: (text) => widget.onChanged!(text), onTap: widget.onTap,
                ),
              )
            : TextFormField(
                maxLines: widget.maxLines ?? 1,
                readOnly: widget.readOnly,
                style: regularDefault.copyWith(color: MyColor.headingTextColor),
                //textAlign: TextAlign.left,
                cursorColor: MyColor.getBodyTextColor(),
                controller: widget.controller,
                autofocus: false,
                textInputAction: widget.inputAction,
                enabled: widget.isEnable,
                focusNode: widget.focusNode,
                validator: widget.validator,
                keyboardType: widget.textInputType,

                obscureText: widget.isPassword ? obscureText : false,
                initialValue: widget.initialValue,
                decoration: InputDecoration(
                  labelStyle: regularDefault.copyWith(color: MyColor.headingTextColor),
                  contentPadding: EdgeInsetsDirectional.symmetric(vertical: Dimensions.space12.w, horizontal: Dimensions.space10.h),
                  hintText: widget.hintText != null ? widget.hintText!.tr : '',
                  hintStyle: regularLarge.copyWith(color: MyColor.hintTextColor),
                  fillColor: widget.fillColor,
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: widget.borderColor), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: widget.borderColor), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: widget.borderColor), borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.isShowSuffixIcon
                      ? widget.isPassword
                          ? GestureDetector(
                              onTap: _toggle,
                              child: Padding(
                                padding: const EdgeInsets.all(Dimensions.space10),
                                child: MyAssetImageWidget(
                                  assetPath: obscureText ? MyImages.eyeInvisibleIcon : MyImages.eyeVisibleIcon,
                                  height: Dimensions.space24.h,
                                  width: Dimensions.space24.h,
                                  boxFit: BoxFit.contain,
                                  color: MyColor.hintTextColor,
                                  isSvg: true,
                                ),
                              ))
                          : widget.suffixImage == true
                              ? widget.suffixWidget
                              : widget.isIcon
                                  ? IconButton(
                                      onPressed: widget.onSuffixTap,
                                      icon: Icon(
                                        widget.isSearch
                                            ? Icons.search_outlined
                                            : widget.isCountryPicker
                                                ? Icons.arrow_drop_down_outlined
                                                : Icons.camera_alt_outlined,
                                        size: 25,
                                        color: MyColor.getPrimaryColor(),
                                      ),
                                    )
                                  : null
                      : null,
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
                onChanged: (text) => widget.onChanged!(text), onTap: widget.onTap,
              )
      ],
    );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
