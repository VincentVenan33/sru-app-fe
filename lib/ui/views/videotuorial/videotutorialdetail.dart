import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/app_constants/colors.dart';
import 'package:mjk_apps/core/app_constants/route.dart';

class VideoTutorialDetailView extends ConsumerStatefulWidget {
  final String videotutorial;

  const VideoTutorialDetailView({Key? key, required this.videotutorial}) : super(key: key);

  @override
  ConsumerState<VideoTutorialDetailView> createState() => _VideoTutorialDetailViewState();

  List<int> getNumbersArray() {
    // Define your array of numbers here
    return [1, 2, 3, 4, 5];
  }
}

class _VideoTutorialDetailViewState extends ConsumerState<VideoTutorialDetailView> with TickerProviderStateMixin {
  final FocusNode stateFocus = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordbaruController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var animation;
  // ignore: prefer_typing_uninitialized_variables
  var controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MjkColor.white,
        appBar: AppBar(
          backgroundColor: MjkColor.backgroundAtas,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            iconSize: 25,
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routes.videotutorial,
              );
            },
          ),
          title: Text(
            widget.videotutorial,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: MjkColor.black,
                    ),
                    child: Image.asset(
                      'assets/images/Group 15460.png',
                      width: double.infinity,
                    ),
                  ),
                  const Text(
                    'Video ini menjelaskan bagaimana cara menambah customer baru',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: MjkColor.navbarUnselectedColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
