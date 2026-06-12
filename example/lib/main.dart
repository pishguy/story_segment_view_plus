import 'package:flutter/material.dart';
import 'package:story_segment_view_plus/story_segment_view_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StorySegmentExample(),
    );
  }
}

class StorySegmentExample extends StatelessWidget {
  const StorySegmentExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Segment View Example'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StorySegmentView(
              imageUrl: 'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_960_720.jpg',
              color: Colors.green,
              segments: 7,
              radius: 40,
              strokeWidth: 3,
            ),
            SizedBox(width: 16),
            StorySegmentView(
              imageUrl: 'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_960_720.jpg',
              color: Colors.blue,
              segments: 4,
              radius: 40,
              strokeWidth: 3,
            ),
            SizedBox(width: 16),
            StorySegmentView(
              imageUrl: 'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_960_720.jpg',
              color: Colors.black,
              segments: 12,
              radius: 40,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
