import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/badges_controller.dart';

import '../../utilities/constants.dart';
import '../../utilities/shimmer_loaders.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({Key? key}) : super(key: key);

  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  BadgesController badgesController = Get.find<BadgesController>();
  getData() async {
    await badgesController.getBadges({}, context);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Center(
                  child: Text(
                "My badge collection",
                style: textStyleBlackB.copyWith(fontSize: 20),
              )),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => SizedBox(
                  height: 80.h,
                  child: badgesController.badges == false
                      ? Shimmers.gridViewShimmer()
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 120,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 3),
                          itemCount: badgesController.badgesData.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GestureDetector(
                              onTap: () async {
                                await badgeDialog(
                                    context,
                                    badgesController.badgesData[index].title,
                                    badgesController.badgesData[index].image,
                                    badgesController
                                        .badgesData[index].description,
                                    badgesController.badgesData[index].win);
                                setState(() {});
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          height: 100,
                                          fit: BoxFit.contain,
                                          imageUrl: badgesController
                                              .badgesData[index].image,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              Shimmers.imageShimmer(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        // SizedBox(
                                        //   height: 100,
                                        //   child: Image.network(
                                        //     badgesController
                                        //         .badgesData[index].image,
                                        //     scale: 4.0,
                                        //     fit: BoxFit.fill,
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                            width: 150,
                                            child: Text(
                                              badgesController
                                                  .badgesData[index].title,
                                              style: textStyleBlackR.copyWith(
                                                  fontSize: 12),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    ),
                                  ),
                                  !badgesController.badgesData[index].win
                                      ? Positioned(
                                          height: 105,
                                          bottom: 20,
                                          child: Container(
                                            color: Colors.transparent,
                                            child: const Icon(
                                              Icons.lock,
                                              shadows: <Shadow>[
                                                Shadow(
                                                    color: Colors.black,
                                                    blurRadius: 20.0)
                                              ],
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            );
                          }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
