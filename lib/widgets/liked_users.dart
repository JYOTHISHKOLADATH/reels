import 'package:flutter/material.dart';
import 'package:reels/model/liked_list_model.dart';
import 'package:reels/service/api_service.dart';

class LikedUsersBottomSheet extends StatelessWidget {
  final int userId;
  final int courseId;

  const LikedUsersBottomSheet({
    Key? key,
    required this.userId,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SeeAllLikedName?>(
      future: ApiService().fetchLikedUsers(userId, courseId), // Use your API method to fetch liked users
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        if (snapshot.hasError || snapshot.data == null || snapshot.data!.data.isEmpty) {
          return Container(
            height: 400,
            color: Colors.black,
            child: const Center(
              child: Text(
                "No liked users yet.",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final likedUsers = snapshot.data!.data;

        return Container(
          height: 400,
          color: Colors.black,
          child: Column(
            children: [
              // Header
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Liked Users",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: likedUsers.length,
                  itemBuilder: (context, index) {
                    final likedUser = likedUsers[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      title: Text(
                        likedUser.likedUserName,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
