import 'package:flutter/material.dart';

class SkeletonUtils {
  static int getLength(
    AsyncSnapshot<List<dynamic>> snapshot, [
    int length = 6,
  ]) {
    if (snapshot.connectionState != ConnectionState.done) {
      return length;
    }

    return snapshot.data?.length ?? length;
  }

  static bool shouldBuildSkeleton(AsyncSnapshot<List<dynamic>> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return true;
    }

    return false;
  }
}
