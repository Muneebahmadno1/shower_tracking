import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/auth_controller.dart';
import 'package:too_cool/screens/navigation_bar/navigation_bar.dart';
import 'package:too_cool/utilities/constants.dart';

import '../../utilities/custom_text_field.dart';
import '../../utilities/custom_validators.dart';
import '../../utilities/global_variables.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class PhysicalAddressScreen extends StatefulWidget {
  const PhysicalAddressScreen({Key? key}) : super(key: key);

  @override
  State<PhysicalAddressScreen> createState() => _PhysicalAddressScreenState();
}

class _PhysicalAddressScreenState extends State<PhysicalAddressScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _address1 = TextEditingController();
  final TextEditingController _address2 = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();
  String countryName = 'United States';

  getCountries() async {
    // await _authController.getCountries(context);
    // Map<String, String> map = {
    //   "fk_country_id": "167",
    // };
    // await _authController.getCities(map, context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Center(
                    child: Text("Tell us where to send your gift?",
                        style: textStyleBlackB.copyWith(fontSize: 18))),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Address Line 1",
                  style: textStyleBlackM,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField.authInputFields(
                  hint: '',
                  validator: (value) => CustomValidator.isEmpty(value),
                  textEditingController: _address1,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Address Line 2 (optional)",
                  style: textStyleBlackM,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField.authInputFields(
                  hint: '',
                  textEditingController: _address2,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "City",
                  style: textStyleBlackM,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField.authInputFields(
                  hint: '',
                  textEditingController: _city,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Country",
                  style: textStyleBlackM,
                ),
                SizedBox(
                  height: 1.h,
                ),
                GestureDetector(
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      countryListTheme: CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.white,
                        textStyle:
                            TextStyle(fontSize: 16, color: Colors.blueGrey),
                        bottomSheetHeight:
                            500, // Optional. Country list modal height
                        //Optional. Sets the border radius for the bottomsheet.
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        //Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      onSelect: (value) {
                        setState(() {
                          countryName = value.name.toString();
                        });
                      },
                      // onSelect: (Country country) => print('Select country: ${country.displayName}'),
                    );
                  },
                  child: Container(
                    height: 8.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 7.0),
                            child: Text(
                              countryName,
                              style: textStyleBlackR,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Image.asset(
                              "assets/icons/arrows.png",
                              scale: 5.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "ZIP / Postcode",
                  style: textStyleBlackM,
                ),
                SizedBox(
                  height: 1.h,
                ),
                SizedBox(
                  width: 50.w,
                  child: CustomTextField.authInputFields(
                    hint: '',
                    keyboardType: TextInputType.number,
                    textEditingController: _zipCode,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                AppButton1(
                    text: "Claim my free gift",
                    btnPressed: () {
                      setState(() {
                        variable = true;
                      });
                      if (formKey.currentState!.validate()) {
                        toSettingDialog(context);
                        Get.to(() => const CommonNavigationBar(index: 0));
                      }
                    }),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
