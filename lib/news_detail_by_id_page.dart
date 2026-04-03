import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/news_detail_page.dart';

class NewsDetailPageById extends StatelessWidget {
  final String newsId;

  const NewsDetailPageById({super.key, required this.newsId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('news')
          .doc(newsId)
          .get(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        return NewsDetailPage(
          title: data['title'] ?? '',
          content: data['body'] ?? '',
          date: data['date'] != null
              ? (data['date'] as Timestamp).toDate()
              : DateTime.now(),
          imageUrl: data['imageUrl'],
        );
      },
    );
  }
}