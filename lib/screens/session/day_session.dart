import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/home_controller.dart';

import '../../utilities/constants.dart';
import '../../utilities/shimmer_loaders.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class DaySessionScreen extends StatefulWidget {
  const DaySessionScreen({Key? key, required this.date}) : super(key: key);
  final DateTime date;
  @override
  State<DaySessionScreen> createState() => _DaySessionScreenState();
}

class _DaySessionScreenState extends State<DaySessionScreen> {
  final HomeController _homeController = Get.find();
  bool loader = false;
  getData() async {
    setState(() {
      loader = true;
    });
    Map<String, String> map = {"date": widget.date.toString().substring(0, 10)};
    await _homeController.getDayShowers(map, context);
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "My Sessions",
          style: textStyleBlackB.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                DateFormat.yMMMMd('en_US').format(widget.date),
                style: textStyleBlackR,
              ),
            ),
            loader == true
                ? SizedBox(
                    height: 78.h,
                    child: Shimmers.challengesShimmer(),
                  )
                : Obx(
                    () => SizedBox(
                      height: 78.h,
                      child: _homeController.dayShowerData.isEmpty
                          ? Center(
                              child: Text(
                                "No Data Found",
                                style: textStyleBlackR.copyWith(fontSize: 16),
                              ),
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: _homeController.dayShowerData.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return RectangleBox.daySessionRectangleBox(
                                    context: context,
                                    color: leadersColors[2],
                                    btnPressed: () {},
                                    title: _homeController
                                        .dayShowerData[index].title,
                                    duration: _homeController
                                        .dayShowerData[index].duration,
                                    date: _homeController
                                        .dayShowerData[index].date);
                              },
                            ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
