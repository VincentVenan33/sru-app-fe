import 'package:flutter/material.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    required this.child,
    this.isLoading = false,
    // this.overlayOpacity = 0.6,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final bool isLoading;
  // final double overlayOpacity;

  @override
  Widget build(BuildContext context) {
    final Size window = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        child,
        isLoading
            ? Container(
                width: window.width,
                height: window.height,
                alignment: Alignment.center,
                color: Colors.white,
                child: const CircularProgressIndicator(
                  strokeWidth: 5,
                  color: MjkColor.blue001,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
