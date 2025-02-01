// To parse this JSON data, do
//
//     final seeAllLikedName = seeAllLikedNameFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SeeAllLikedName seeAllLikedNameFromJson(String str) => SeeAllLikedName.fromJson(json.decode(str));

String seeAllLikedNameToJson(SeeAllLikedName data) => json.encode(data.toJson());

class SeeAllLikedName {
  final bool success;
  final String message;
  final List<Datum> data;

  SeeAllLikedName({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SeeAllLikedName.fromJson(Map<String, dynamic> json) => SeeAllLikedName(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final int courseId;
  final int userId;
  final String likedUserName;

  Datum({
    required this.id,
    required this.courseId,
    required this.userId,
    required this.likedUserName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    courseId: json["course_id"],
    userId: json["user_id"],
    likedUserName: json["liked_user_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_id": courseId,
    "user_id": userId,
    "liked_user_name": likedUserName,
  };
}
