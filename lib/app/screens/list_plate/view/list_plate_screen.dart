import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/buttons/card_button.dart';
import 'package:ovolutter/app/components/buttons/price_selection_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/image/my_network_image_widget.dart';
import 'package:ovolutter/app/components/no_data.dart';
import 'package:ovolutter/app/components/not_logged_in.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/app/components/text-field/custom_drop_down.dart';
import 'package:ovolutter/app/components/text-field/custom_text_field.dart';
import 'package:ovolutter/app/components/user_details/user_details_data.dart';
import 'package:ovolutter/app/screens/global/widgets/country_bottom_sheet.dart';
import 'package:ovolutter/app/screens/list_plate/controller/liast_plate_controller.dart';
import 'package:ovolutter/core/helper/date_converter.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/model/ads_details/ads_details_response_model.dart';
import 'package:ovolutter/data/model/country_model/country_model.dart';
import 'package:ovolutter/data/repo/list_plate/list_plate_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';
import 'package:ovolutter/environment.dart';

class ListPlateScreen extends StatefulWidget {
  const ListPlateScreen({super.key});

  @override
  State<ListPlateScreen> createState() => _ListPlateScreenState();
}

class _ListPlateScreenState extends State<ListPlateScreen> {
  @override
  void initState() {
    Get.put(ListPlateRepo());
    final controller = Get.put(ListPlatesController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.isRequest = Get.arguments[0];
      controller.token = SharedPreferenceService.getAccessToken();

      controller.update();
      if (controller.token != "") {
        controller.resetData();
        controller.plateDetailsData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListPlatesController>(
        builder: (controller) => MyCustomScaffold(
              pageTitle: controller.isRequest == true ? MyStrings.requestYourPlate.tr : MyStrings.listYourPlate.tr,
              centerTitle: true,
              body: controller.isLoading
                  ? Center(child: CustomLoader())
                  : controller.token == ""
                      ? NotLoggedinWidget(
                          text: MyStrings.logIntoAddPlatelist,
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    MyStrings.stepOneOfTwo.tr,
                                    style: regularLarge.copyWith(color: MyColor.headingTextColor, fontFamily: 'poppins'),
                                  ),
                                  spaceSide(Dimensions.space16),
                                  Expanded(
                                      child: TwoStepStepper(
                                    currentStep: controller.currentPage,
                                  )),
                                ],
                              ),
                              spaceDown(Dimensions.space16),
                              if (controller.currentPage == 1) ...[
                                if (controller.isRequest == false) ...[
                                  Text(
                                    MyStrings.addInformation.tr,
                                    style: semiBoldMediumLarge.copyWith(color: MyColor.headingTextColor, fontFamily: 'poppins'),
                                  ),
                                  Text(
                                    MyStrings.buyersWillConnectYouDirectly.tr,
                                    style: regularLarge.copyWith(color: MyColor.hintTextColor),
                                  ),
                                  spaceDown(Dimensions.space12),
                                  IntrinsicWidth(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: PriceSelectionButton(
                                            isActive: controller.callForPrice == true ? true : false,
                                            text: MyStrings.callForPrice,
                                            onTap: () {
                                              controller.changeAdvanceSearchStatus();
                                            },
                                          ),
                                        ),
                                        spaceSide(Dimensions.space16),
                                        Expanded(
                                          child: PriceSelectionButton(
                                            isActive: controller.callForPrice == false ? true : false,
                                            text: MyStrings.price,
                                            onTap: () {
                                              controller.changeAdvanceSearchStatus();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  spaceDown(Dimensions.space16),
                                  !controller.callForPrice
                                      ? CustomAppCard(
                                          showShadow: false,
                                          showBorder: false,
                                          radius: Dimensions.space16,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                MyStrings.addPlatePrice.tr,
                                                style: regularLarge.copyWith(color: MyColor.headingTextColor, fontWeight: FontWeight.w500, fontFamily: 'poppins'),
                                              ),
                                              spaceDown(Dimensions.space12),
                                              CustomTextField(
                                                isRequired: true,
                                                controller: controller.priceController,
                                                onChanged: () {},
                                                showShadow: true,
                                                labelText: MyStrings.price.toTitleCase().tr,
                                                hintText: MyStrings.plateHint.tr,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return MyStrings.fieldErrorMsg.tr;
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ],
                                          ))
                                      : SizedBox.shrink()
                                ],
                                spaceDown(Dimensions.space16),
                                CustomAppCard(
                                    showShadow: false,
                                    showBorder: false,
                                    radius: Dimensions.space16,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          MyStrings.plateDetails.tr,
                                          style: regularLarge.copyWith(color: MyColor.headingTextColor, fontWeight: FontWeight.w500, fontFamily: 'poppins'),
                                        ),
                                        spaceDown(Dimensions.space12),
                                        CustomTextField(
                                          isRequired: true,
                                          controller: controller.plateNoController,
                                          onChanged: () {},
                                          showShadow: true,
                                          maxlength: 5,
                                          labelText: MyStrings.plateNumber.toTitleCase().tr,
                                          hintText: MyStrings.plateHint.tr,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return MyStrings.fieldErrorMsg.tr;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        spaceDown(Dimensions.space12),
                                        CustomTextField(
                                          isRequired: true,
                                          controller: controller.plateLetterController,
                                          onChanged: () {},
                                          maxlength: 1,
                                          showShadow: true,
                                          fillColor: MyColor.white,
                                          labelText: MyStrings.plateLetter.toTitleCase().tr,
                                          hintText: MyStrings.plateHint.tr,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return MyStrings.fieldErrorMsg.tr;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        spaceDown(Dimensions.space12),
                                        Text(MyStrings.city.tr, style: regularDefault.copyWith(color: MyColor.headingTextColor)),
                                        spaceDown(Dimensions.space8),
                                        CustomDropdown(
                                          hint: MyStrings.select,
                                          value: controller.selectedCity,
                                          items: controller.cities.map((e) => e.name ?? '').toList(),
                                          onChanged: (String? newValue) {
                                            controller.selectedCity = newValue;
                                            final city = controller.cities.firstWhere(
                                              (c) => c.name == newValue,
                                              orElse: () => City(),
                                            );

                                            controller.selectedCityId = city.id;

                                            controller.update();
                                          },
                                        ),
                                      ],
                                    )),
                                spaceDown(Dimensions.space16),
                                Text(
                                  MyStrings.plateType.tr,
                                  style: regularLarge.copyWith(color: MyColor.headingTextColor, fontWeight: FontWeight.w500, fontFamily: 'poppins'),
                                ),
                                spaceDown(Dimensions.space12),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .065),
                                  child: ListView.separated(
                                      separatorBuilder: (context, index) => spaceSide(Dimensions.space16),
                                      itemCount: controller.plateTypes.length,
                                      padding: EdgeInsetsDirectional.symmetric(vertical: Dimensions.space4),
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return CustomAppCard(
                                            onPressed: () {
                                              controller.changeCarType(index);
                                            },
                                            showBorder: false,
                                            showShadow: false,
                                            backgroundColor: controller.currentIndex == index ? hexToColor(controller.plateTypes[index].colorCode ?? 'FFFFFF') : MyColor.white,
                                            padding: EdgeInsetsDirectional.symmetric(vertical: Dimensions.space8, horizontal: Dimensions.space16),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                MyAssetImageWidget(
                                                  assetPath: MyImages.demoButtonCar,
                                                  height: Dimensions.space32.h,
                                                  width: Dimensions.space32.h,
                                                ),
                                                spaceSide(Dimensions.space8),
                                                Text(
                                                  controller.plateTypes[index].type ?? "",
                                                  style: regularLarge.copyWith(color: controller.currentIndex != index ? MyColor.headingTextColor : MyColor.white),
                                                )
                                              ],
                                            ));
                                      }),
                                ),
                              ],
                              if (controller.currentPage == 2) ...[
                                CustomAppCard(
                                    padding: EdgeInsets.all(Dimensions.space16),
                                    radius: Dimensions.space16,
                                    showBorder: false,
                                    showShadow: false,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          MyStrings.addYourContactInformation.tr,
                                          style: semiBoldMediumLarge.copyWith(fontFamily: 'poppins', color: MyColor.headingTextColor),
                                        ),
                                        spaceDown(Dimensions.space12),
                                        CustomAppCard(
                                          radius: Dimensions.space16,
                                          child: UserDetailsData(
                                            name: controller.user.username ?? "",
                                            subtitle: "${MyStrings.memberSince} ${DateConverter().formatRelativeDateFromJson(controller.user.createdAt ?? "")}",
                                            userImage: "${UrlContainer.domainUrl}/${controller.user.imagePath}/${controller.user.image}",
                                          ),
                                        ),
                                        spaceDown(Dimensions.space12 * 2),
                                        CustomTextField(
                                          controller: controller.mobileNoController,
                                          onChanged: () {},
                                          isRequired: true,
                                          suffixImage: true,
                                          isShowSuffixIcon: true,
                                          suffixWidget: Padding(
                                            padding: EdgeInsets.all(Dimensions.space8),
                                            child: MyAssetImageWidget(
                                              assetPath: MyImages.whatsApp,
                                              height: Dimensions.space24.h,
                                              width: Dimensions.space24.h,
                                            ),
                                          ),
                                          labelText: MyStrings.whatsAppNumber.toTitleCase().tr,
                                          hintText: MyStrings.enterYourPhoneNumber.tr,
                                          prefixIcon: Container(
                                            margin: EdgeInsets.all(1),
                                            decoration: BoxDecoration(color: MyColor.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.cardRadius), topLeft: Radius.circular(Dimensions.cardRadius))),
                                            child: SizedBox(
                                              width: 110,
                                              child: FittedBox(
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        CountryBottomSheet.countryBottomSheet(context, onSelectedData: (Countries data) {
                                                          controller.selectWhatsAppCountry(countryDataValue: data);
                                                        });
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space12),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        alignment: Alignment.center,
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius: BorderRadiusGeometry.circular(Dimensions.space100),
                                                              child: MyNetworkImageWidget(
                                                                imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", (controller.whatsAppCountryData?.countryCode ?? Environment.defaultCountryCode).toLowerCase()),
                                                                height: Dimensions.space20,
                                                                width: Dimensions.space20,
                                                              ),
                                                            ),
                                                            const SizedBox(width: Dimensions.space5),
                                                            Text(
                                                              "+${controller.whatsAppCountryData?.dialCode ?? ''}",
                                                              style: regularDefault,
                                                            ),
                                                            const SizedBox(width: Dimensions.space3),
                                                            const SizedBox(width: Dimensions.space8)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if ((value as String).trim().isEmpty) {
                                              return MyStrings.kUsernameIsRequired.tr;
                                            } else if (value.length < 6) {
                                              return MyStrings.kShortUserNameError.tr;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        spaceDown(Dimensions.space12),
                                        CustomTextField(
                                          controller: controller.whatsAppNoController,
                                          onChanged: () {},
                                          isRequired: true,
                                          labelText: MyStrings.phoneNumber.toTitleCase().tr,
                                          hintText: MyStrings.enterYourPhoneNumber.tr,
                                          prefixIcon: Container(
                                            margin: EdgeInsets.all(1),
                                            decoration: BoxDecoration(color: MyColor.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.cardRadius), topLeft: Radius.circular(Dimensions.cardRadius))),
                                            child: SizedBox(
                                              width: 110,
                                              child: FittedBox(
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        CountryBottomSheet.countryBottomSheet(context, onSelectedData: (Countries data) {
                                                          controller.selectPhoneCountry(countryDataValue: data);
                                                        });
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space12),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        alignment: Alignment.center,
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius: BorderRadiusGeometry.circular(Dimensions.space100),
                                                              child: MyNetworkImageWidget(
                                                                imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", (controller.phoneCountryData?.countryCode ?? Environment.defaultCountryCode).toLowerCase()),
                                                                height: Dimensions.space20,
                                                                width: Dimensions.space20,
                                                              ),
                                                            ),
                                                            const SizedBox(width: Dimensions.space5),
                                                            Text(
                                                              "+${controller.phoneCountryData?.dialCode ?? ''}",
                                                              style: regularDefault,
                                                            ),
                                                            const SizedBox(width: Dimensions.space3),
                                                            const SizedBox(width: Dimensions.space8)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if ((value as String).trim().isEmpty) {
                                              return MyStrings.kUsernameIsRequired.tr;
                                            } else if (value.length < 6) {
                                              return MyStrings.kShortUserNameError.tr;
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ],
                                    ))
                              ],
                              spaceDown(Dimensions.space100),
                            ],
                          ),
                        ),
              bottomNav: GetBuilder<ListPlatesController>(
                builder: (controller) => controller.token == ""
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.all(Dimensions.space16),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: MyColor.black.withValues(alpha: .15),
                            blurRadius: 4,
                            spreadRadius: 4,
                            offset: const Offset(6, 0),
                          ),
                        ], color: MyColor.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.cardRadius), topRight: Radius.circular(Dimensions.cardRadius))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CardButton(
                              loaderColor: MyColor.white,
                              isLoading: controller.isSubmitLoading,
                              icon: "",
                              press: () {
                                if (controller.plateLetterController.text.isNotEmpty && controller.plateNoController.text.isNotEmpty && controller.selectedCityId != "" && controller.carId != "") {
                                  if (controller.currentPage == 1) {
                                    controller.currentPage++;
                                  } else {
                                    if (controller.whatsAppDialCode != "" && controller.mobileNumberDialCode != "") {
                                      controller.addPlate();
                                    } else {
                                      CustomSnackBar.error(errorList: [MyStrings.selectACountry.tr]);
                                    }
                                  }

                                  controller.update();
                                } else {
                                  CustomSnackBar.error(errorList: [MyStrings.fillAllTheField.tr]);
                                }
                              },
                              borderColor: MyColor.blackColorShadow,
                              text: MyStrings.continue_,
                            ),
                            spaceDown(Dimensions.space25)
                          ],
                        ),
                      ),
              ),
            ));
  }

  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}

class TwoStepStepper extends StatelessWidget {
  final int currentStep;
  final double height;

  const TwoStepStepper({
    super.key,
    required this.currentStep,
    this.height = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Row(
        children: List.generate(2, (index) {
          final isActive = currentStep >= index + 1;

          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: height,
              color: isActive ? MyColor.lightInformation : MyColor.white,
            ),
          );
        }),
      ),
    );
  }
}
