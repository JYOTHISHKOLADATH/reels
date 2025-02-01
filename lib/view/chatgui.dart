import 'package:flutter/material.dart';
import 'package:reels/controller/course_reel_controller.dart';
import 'package:reels/service/api_service.dart';
import 'package:reels/widgets/commentsection.dart';
import 'package:reels/widgets/liked_users.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import '../model/seecomments_model.dart';

class ReelsScreen extends StatefulWidget {
  @override
  _ReelsScreenState createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final CourseReelController controller = Get.put(CourseReelController());
  final PageController _pageController = PageController();

  @override
  void dispose() {
    print("Disposing video controllers...");
    for (var ctrl in controller.videoControllers) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void _onPageChanged(int index) {
    print("Page changed to index $index.");
    // Pause all other videos
    for (var ctrl in controller.videoControllers) {
      if (ctrl.value.isPlaying) {
        ctrl.pause();
      }
    }
    // Play the current video
    controller.videoControllers[index].play();
  }

  void togglePlayPause(int index) {
    if (controller.videoControllers[index].value.isPlaying) {
      controller.videoControllers[index].pause();
    } else {
      controller.videoControllers[index].play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (controller.isLoading.value) {
          print("Loading reels...");
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.courseReels.isEmpty) {
          print("No course reels available.");
          return const Center(child: Text("No Course Reels Available", style: TextStyle(color: Colors.white)));
        }

        return PageView.builder(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          itemCount: controller.courseReels.length,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) {
            print("Building video player for index $index...");
            // Initialize the video player with the local asset for every index
            if (controller.videoControllers.length <= index) {
              controller.videoControllers.add(
                VideoPlayerController.asset('assets/reel/samplereel.mp4')..initialize().then((_) {
                  setState(() {});
                }),
              );
            }

            return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                // Check if video is initialized or not
                controller.videoControllers.length > index &&
                    controller.videoControllers[index].value.isInitialized
                    ? GestureDetector(
                  onTap: () => togglePlayPause(index), // Toggle play/pause on tap
                  child: SizedBox.expand(
                    child: VideoPlayer(controller.videoControllers[index]),
                  ),
                )
                    : Stack(
                  alignment: Alignment.center,
                  children: [
                    // Show thumbnail while the video is loading
                    CachedNetworkImage(
                      imageUrl:
                      "https://xianinfotech.in/edxera/public/${controller.courseReels[index].courseThumbnail}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, color: Colors.white),
                    ),
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ), // Show a loader until video is ready
                  ],
                ),
                _buildOverlayUI(
                  controller.courseReels[index].title,
                  controller.courseReels[index].courseLikeCount,
                  controller.courseReels[index].courseCommentCount,
                  controller.courseReels[index].id,
                  controller.courseReels[index].courseViewCount,
                  controller.courseReels[index].isLiked,
                  index,
                ),
              ],
            );
          },
        );
      }),
    );
  }

  Widget _buildOverlayUI(
      String title, int likes, int comments, id, views, isLiked, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconWithCount(
                    isLiked != 1 ? Icons.favorite_border : Icons.favorite, likes, onPressed: () {
                  _showLikedUsersBottomSheet(context, 498, id);

      // _showCommentsBottomSheet(498,6);
      }),
                _buildIconWithCount(Icons.comment, comments, onPressed: () {
                 _showCommentsBottomSheet(context, 498, id);

                  // _showCommentsBottomSheet(498,6);
                }),
                _buildIconWithCount(Icons.visibility_outlined, views),
                Text(
                  "Id : $id",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithCount(IconData icon, int count, {Function()? onPressed}) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: IconButton(
            icon: Icon(icon, color: Colors.black, size: 30),
            onPressed: onPressed ?? () {},
          ),
        ),
        Positioned(
          bottom: 0,
          right: 20,
          child: Center(
            child: Text(
              '$count',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
  void _showCommentsBottomSheet(BuildContext context, int userId, int courseId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => CommentsBottomSheet(userId: userId, courseId: courseId),
    );
  }

  void _showLikedUsersBottomSheet(BuildContext context, int userId, int courseId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => LikedUsersBottomSheet(userId: userId, courseId: courseId),
    );
  }



}
