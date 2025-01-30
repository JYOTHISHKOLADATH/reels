class CourseReel {
  final int id;
  final String title;
  final String courseReelVideo;
  final String courseThumbnail;
  final int courseLikeCount;
  final int courseViewCount;
  final int courseCommentCount;
  final int isLiked;

  CourseReel({
    required this.id,
    required this.title,
    required this.courseReelVideo,
    required this.courseThumbnail,
    required this.courseLikeCount,
    required this.courseViewCount,
    required this.courseCommentCount,
    required this.isLiked,
  });

  factory CourseReel.fromJson(Map<String, dynamic> json) {
    return CourseReel(
      id: json["id"],
      title: json["title"],
      courseReelVideo: json["course_reel_video"],
      courseThumbnail: json["course_thumbnail"],
      courseLikeCount: json["course_like_count"],
      courseViewCount: json["course_view_count"],
      courseCommentCount: json["course_comment_count"],
      isLiked: json["is_liked"],
    );
  }
}
