// To parse this JSON data, do
//
//     final seeAllComments = seeAllCommentsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SeeAllComments seeAllCommentsFromJson(String str) => SeeAllComments.fromJson(json.decode(str));

String seeAllCommentsToJson(SeeAllComments data) => json.encode(data.toJson());

class SeeAllComments {
  final bool success;
  final String message;
  final List<Datum> data;

  SeeAllComments({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SeeAllComments.fromJson(Map<String, dynamic> json) => SeeAllComments(
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
  final String comment;
  final String likedUserName;

  Datum({
    required this.id,
    required this.courseId,
    required this.userId,
    required this.comment,
    required this.likedUserName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    courseId: json["course_id"],
    userId: json["user_id"],
    comment: json["comment"],
    likedUserName: json["liked_user_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_id": courseId,
    "user_id": userId,
    "comment": comment,
    "liked_user_name": likedUserName,
  };
}
