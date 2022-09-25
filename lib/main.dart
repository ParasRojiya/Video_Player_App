import 'package:flutter/material.dart';
import 'package:video_player_app/screens/homepage.dart';
import 'package:video_player_app/screens/video_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => const HomePage(),
      'video_page': (context) => const VideoPage(),
    },
  ));
}
