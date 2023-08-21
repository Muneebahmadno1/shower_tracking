import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class Shimmers {
  static listTileShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 28.0),
        itemCount: 5,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Container(
              width: 90.w,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  static gridViewShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 117,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3),
          itemCount: 30,
          itemBuilder: (BuildContext ctx, index) {
            return Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  static challengesShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: 15,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Container(
              width: 90.w,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  static imageShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
      ),
    );
  }
}
