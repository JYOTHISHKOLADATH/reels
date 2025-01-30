// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class ReelsScreen extends StatefulWidget {
//   @override
//   _ReelsScreenState createState() => _ReelsScreenState();
// }
//
// class _ReelsScreenState extends State<ReelsScreen> {
//   final List<String> videoUrls = [
//     'https://youtube.com/shorts/gJy1hzMJZKc?si=2izkvQYTjjhx3042',
//     'https://youtube.com/shorts/pyUg1GLk30A?si=MRftpswAt5MU9tFb',
//     'https://youtube.com/shorts/XtEJ8b9TECo?si=DhV21pPs2G5VtvA8',
//   ];
//
//   List<YoutubePlayerController> _controllers = [];
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeVideos();
//   }
//
//   void _initializeVideos() {
//     _controllers = videoUrls.asMap().entries.map((entry) {
//       int index = entry.key;
//       String? videoId = YoutubePlayer.convertUrlToId(entry.value);
//       var controller = YoutubePlayerController(
//         initialVideoId: videoId!,
//         flags: const YoutubePlayerFlags(
//           autoPlay: true,
//           mute: false,
//           loop: false,
//           forceHD: true,
//           hideThumbnail: true,
//         ),
//       );
//
//       // Listen for video state changes
//       controller.addListener(() {
//         if (controller.value.playerState == PlayerState.ended) {
//           _moveToNextVideo(index);
//         }
//       });
//
//       return controller;
//     }).toList();
//   }
//
//   void _moveToNextVideo(int currentIndex) {
//     if (currentIndex < videoUrls.length - 1) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   void _onPageChanged(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//
//     for (var controller in _controllers) {
//       controller.pause();
//     }
//
//     _controllers[index].play();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: PageView.builder(
//         scrollDirection: Axis.vertical,
//         controller: _pageController,
//         itemCount: videoUrls.length,
//         onPageChanged: _onPageChanged,
//         itemBuilder: (context, index) {
//           return Stack(
//             alignment: Alignment.bottomLeft,
//             children: [
//               SizedBox.expand(
//                 child: YoutubePlayer(
//                   controller: _controllers[index],
//                   showVideoProgressIndicator: true,
//                 ),
//               ),
//               _buildOverlayUI(),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildOverlayUI() {
//     return const Padding(
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Text("@username", style: TextStyle(color: Colors.white, fontSize: 18)),
//           // Text("Caption goes here...", style: TextStyle(color: Colors.white70)),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Icon(Icons.favorite_border, color: Colors.white, size: 30),
//               SizedBox(width: 10),
//               Icon(Icons.comment, color: Colors.white, size: 30),
//               SizedBox(width: 10),
//               Icon(Icons.share, color: Colors.white, size: 30),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
