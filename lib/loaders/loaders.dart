import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

shimmerCategoryLoader(){
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle
        ),
        width: 75,
        height: 75,
      )
  );
}