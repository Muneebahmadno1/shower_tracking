import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/screens/auth/address.dart';
import 'package:too_cool/screens/navigation_bar/navigation_bar.dart';
import 'package:too_cool/utilities/constants.dart';
import 'package:too_cool/utilities/styles.dart';

import '../../utilities/widgets.dart';

class SubscribeScreen extends StatefulWidget {
  const SubscribeScreen({Key? key}) : super(key: key);

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

enum PaymentOption { lifetime, annual, week }

class _SubscribeScreenState extends State<SubscribeScreen> {
  PaymentOption? _payment = PaymentOption.lifetime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   toSettingDialog(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "FREE",
                          style: textStyleBlackTHICCCBOIB.copyWith(
                              fontSize: 55,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      "Waterproof shower case with \n annual & lifetime subscriptions",
                      style: textStyleBlackTHICCCBOIB.copyWith(
                          color: HexColor("#83BCFF"),
                          fontSize: 19,
                          height: 1.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                            left: 9.0, right: 9.0, top: 5.0, bottom: 5.0),
                        decoration: BoxDecoration(
                            color: HexColor('#A0FFED'),
                            borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          "Valued at \$21.99",
                          style: textStyleBlackTHICCCBOIM.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 35.h,
                      width: 90.w,
                      child: Image.asset(
                        Asset.subscribeLogo,
                        fit: BoxFit.contain,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _payment = PaymentOption.lifetime;
                        });
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: _payment == PaymentOption.lifetime
                                    ? HexColor("#83BCFF")
                                    : Colors.transparent,
                                width: 2),
                            color: _payment == PaymentOption.lifetime
                                ? Colors.white
                                : HexColor("#D6D6D6")),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio<PaymentOption>(
                                  value: PaymentOption.lifetime,
                                  groupValue: _payment,
                                  onChanged: (PaymentOption? value) {
                                    setState(() {
                                      _payment = value;
                                    });
                                  },
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Lifetime",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Plus-EB',
                                          fontSize: 17),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\$59.99,",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'Plus-EB',
                                              fontSize: 15),
                                        ),
                                        Text(
                                          " one payment",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Plus-B',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 9.0,
                                      right: 9.0,
                                      top: 5.0,
                                      bottom: 5.0),
                                  decoration: BoxDecoration(
                                      color: HexColor('#A0FFED'),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: const Text(
                                    "Free Case",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Plus-EB',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.center,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _payment = PaymentOption.annual;
                        });
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: _payment == PaymentOption.annual
                                    ? HexColor("#83BCFF")
                                    : Colors.transparent,
                                width: 2),
                            color: _payment == PaymentOption.annual
                                ? Colors.white
                                : HexColor("#D6D6D6")),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio<PaymentOption>(
                                  value: PaymentOption.annual,
                                  groupValue: _payment,
                                  onChanged: (PaymentOption? value) {
                                    setState(() {
                                      _payment = value;
                                    });
                                  },
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Annual",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Plus-EB',
                                          fontSize: 17),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\$49.99,",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'Plus-EB',
                                              fontSize: 15),
                                        ),
                                        Text(
                                          " yearly payment",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Plus-B',
                                              fontSize: 15),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 9.0,
                                      right: 9.0,
                                      top: 5.0,
                                      bottom: 5.0),
                                  decoration: BoxDecoration(
                                      color: HexColor('#A0FFED'),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: const Text(
                                    "Free Case",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Plus-EB',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w900),
                                    textAlign: TextAlign.center,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _payment = PaymentOption.week;
                        });
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: _payment == PaymentOption.week
                                    ? HexColor("#83BCFF")
                                    : Colors.transparent,
                                width: 2),
                            color: _payment == PaymentOption.week
                                ? Colors.white
                                : HexColor("#D6D6D6")),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio<PaymentOption>(
                                  value: PaymentOption.week,
                                  groupValue: _payment,
                                  onChanged: (PaymentOption? value) {
                                    setState(() {
                                      _payment = value;
                                    });
                                  },
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "7 Day Free Trial",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Plus-EB',
                                          fontSize: 17),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Then \$6.99/month,",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'Plus-EB',
                                              fontSize: 15),
                                        ),
                                        Text(
                                          " auto renewal",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Plus-B',
                                              fontSize: 15),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Hello");
                        _payment == PaymentOption.week
                            ? toSettingDialog(context)
                            : Null;
                        _payment == PaymentOption.week
                            ? Get.to(() => const CommonNavigationBar(index: 0))
                            : Get.to(() => const PhysicalAddressScreen());
                      },
                      child: Container(
                        height: 55,
                        width: 90.w,
                        decoration: BoxDecoration(
                            color: HexColor('#83BCFF'),
                            borderRadius: BorderRadius.circular(8)),
                        alignment: Alignment.center,
                        child: const Text(
                          "Let's get Cool",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Plus-EB',
                              fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                  ],
                ),
                Positioned(
                  top: 34.h + 160,
                  left: 33.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor('#83BCFF'),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 6.0),
                      child: Text(
                        "Best Value",
                        style: textStyleBlackB.copyWith(
                            fontSize: 15,
                            fontFamily: "Plus-EB",
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
