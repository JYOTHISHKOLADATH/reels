import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:reels/model/course_reel_model.dart';
import 'package:reels/model/liked_list_model.dart';

import '../model/seecomments_model.dart';

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




  Future<SeeAllComments?> fetchComments(int userId, int courseId) async {
    try {

      Response response = await _dio.post(
        "https://xianinfotech.in/edxera/api/view_course_comments",
        data: {
          "user_id": userId,
          'course_id': courseId
        },
        // options: Options(
        //   headers: {
        //     "Content-Type": "application/json",
        //   },
        // ),
      );
      // final response = await _dio.get(
      //   'https://xianinfotech.in/edxera/api/view_course_comments',
      //   queryParameters: {'user_id': userId, 'course_id': courseId},
      // );

      if (response.statusCode == 200) {
        return seeAllCommentsFromJson(jsonEncode(response.data)); // Convert to JSON string
      }else {
        print("Error: ${response.statusCode} - ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error fetching comments: $e");
      return null;
    }
  }


  Future<SeeAllLikedName?> fetchLikedUsers(int userId, int courseId) async {
    try {

      Response response = await _dio.post(
        "https://xianinfotech.in/edxera/api/view_course_likes",
        data: {
          "user_id": userId,
          'course_id': courseId
        },
        // options: Options(
        //   headers: {
        //     "Content-Type": "application/json",
        //   },
        // ),
      );
      // final response = await _dio.get(
      //   'https://xianinfotech.in/edxera/api/view_course_comments',
      //   queryParameters: {'user_id': userId, 'course_id': courseId},
      // );

      if (response.statusCode == 200) {
        return seeAllLikedNameFromJson(jsonEncode(response.data)); // Convert to JSON string
      }else {
        print("Error: ${response.statusCode} - ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error fetching comments: $e");
      return null;
    }
  }

}


