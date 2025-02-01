import 'package:flutter/material.dart';
import 'package:reels/model/seecomments_model.dart';
import 'package:reels/service/api_service.dart';

class CommentsBottomSheet extends StatelessWidget {
  final int userId;
  final int courseId;

  const CommentsBottomSheet({
    Key? key,
    required this.userId,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SeeAllComments?>(
      future: ApiService().fetchComments(userId, courseId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        if (snapshot.hasError || snapshot.data == null || snapshot.data!.data == null) {
          return const SizedBox(
            height: 400,
            child: Center(
              child: Text(
                "Failed to load comments.",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final comments = snapshot.data!.data!;

        return Container(
          height: 400,
          color: Colors.black,
          child: Column(
            children: [
              // Header
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Comments",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Expanded(
                child: comments.isEmpty
                    ? const Center(
                  child: Text(
                    "No comments yet.",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
                    : ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      title: Text(
                        comment.likedUserName ?? "Loading...",
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        comment.comment ?? "Loading...",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    );
                  },
                ),
              ),
              // Comment input field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[800],
                    hintText: "Add a comment...",
                    hintStyle: const TextStyle(color: Colors.white60),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
