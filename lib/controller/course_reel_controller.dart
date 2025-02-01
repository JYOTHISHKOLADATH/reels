import 'package:get/get.dart';
import 'package:reels/model/course_reel_model.dart';
import 'package:reels/service/api_service.dart';
import 'package:video_player/video_player.dart';
class CourseReelController extends GetxController {
  var isLoading = true.obs;
  var courseReels = <CourseReel>[].obs;
  var videoControllers = <VideoPlayerController>[].obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    print("Fetching course reels...");
    fetchReels(498);
    super.onInit();
  }

  Future<void> fetchReels(int userId) async {
    try {
      isLoading(true);

      print("Sending API request...");
      var reels = await _apiService.fetchCourseReels(userId);
      print("API response received.");
      courseReels.assignAll(reels);
      // await _initializeVideoControllers();
      isLoading(false);
    } catch (e) {
      print("Error fetching course reels: $e");
      isLoading(false);
    }
  }

  // Future<void> _initializeVideoControllers() async {
  //   print("Initializing video controllers...");
  //   List<VideoPlayerController> controllers = [];
  //   for (var reel in courseReels) {
  //     String videoUrl = "https://xianinfotech.in/edxera/public/${reel.courseReelVideo}";
  //     print("Initializing video: $videoUrl");
  //     var controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
  //     try {
  //       await controller.initialize();
  //       print("Video initialized: $videoUrl");
  //       controllers.add(controller);
  //     } catch (e) {
  //       print("Error initializing video: $videoUrl - $e");
  //     }
  //   }
  //   videoControllers.assignAll(controllers);
  // }

  // bool isVideoInitialized(int index) {
  //   bool initialized = videoControllers[index].value.isInitialized;
  //   if (initialized) {
  //     print("Video at index $index is initialized.");
  //   } else {
  //     print("Video at index $index is NOT initialized.");
  //   }
  //   return initialized;
  // }
}
