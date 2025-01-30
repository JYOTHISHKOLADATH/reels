import 'package:dio/dio.dart';
import 'package:reels/model/course_reel_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final String apiUrl = "https://xianinfotech.in/edxera/api/get_course_reels";

  Future<List<CourseReel>> fetchCourseReels(int userId) async {
    try {
      Response response = await _dio.post(
        apiUrl,
        data: {"user_id": userId},
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 && response.data["success"]) {
        List<dynamic> data = response.data["data"];
        return data.map((json) => CourseReel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch course reels");
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
