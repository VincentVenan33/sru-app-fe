import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/app_constants/colors.dart';
import 'package:sru/core/app_constants/route.dart';
import 'package:sru/ui/shared/spacings.dart';
import 'package:sru/ui/shared/unfocus_helper.dart';
import 'package:sru/ui/views/videotuorial/videotutorialdetail.dart';

class VideoTutorialView extends ConsumerStatefulWidget {
  const VideoTutorialView({super.key});

  @override
  ConsumerState<VideoTutorialView> createState() => _VideoTutorialViewState();
}

class _VideoTutorialViewState extends ConsumerState<VideoTutorialView> with TickerProviderStateMixin {
  double scrollPosition = 0.0;
  bool tabIsHide = false;

  @override
  Widget build(BuildContext context) {
    return UnfocusHelper(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: sruColor.white,
          appBar: AppBar(
            backgroundColor: sruColor.backgroundAtas,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              iconSize: 25,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.akun,
                );
              },
            ),
            title: const Text(
              'Video Tutorial',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            child: ListView.separated(
              separatorBuilder: (_, __) => Spacings.verSpace(12),
              itemCount: 10,
              itemBuilder: (context, index) {
                final videoTitle = "Video Tutorial ${index + 1}";
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoTutorialDetailView(
                              videotutorial: videoTitle,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Color(sruColor.transparent.value),
                        surfaceTintColor: Colors.white,
                        shadowColor: const Color(0x00000000),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.zero,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 0,
                              right: 20,
                              top: 10,
                              bottom: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageIcon(
                                  AssetImage(
                                    'assets/icons/lets-icons_video.png',
                                  ),
                                  color: sruColor.black,
                                )
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                videoTitle, // Use the dynamic title
                                style: const TextStyle(
                                  fontSize: 15.38,
                                  fontWeight: FontWeight.bold,
                                  color: sruColor.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Spacings.verSpace(20),
                    const Column(
                      children: [
                        Divider(
                          height: 1,
                          color: sruColor.lightBlack009,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
