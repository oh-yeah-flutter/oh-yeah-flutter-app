import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  final String title;
  final String content;
  final DateTime date;
  final String? imageUrl;

  const NewsDetailPage({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0D3C2),

      appBar: AppBar(
        backgroundColor: const Color(0xFF3E2723),
        centerTitle: true, // 🔥 中央
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "NEWS",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔥 画像（上）
            if (imageUrl != null && imageUrl!.isNotEmpty)
              CachedNetworkImage(
                imageUrl: imageUrl!,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
              ),

            /// 🔥 カード
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 日付
                  Text(
                    "${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// タイトル
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 本文（修正済み）
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 18, // 🔥 タイトルと同じ
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // 🔥 黒
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF3E2723),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "HOME",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: "NEWS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.facebook),
            label: "FACEBOOK",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: "Instagram",
          ),
        ],
        onTap: (index) async {
          if (index == 0) {
            // HOME - トップ画面に戻る（スタックをクリア）
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/home',
              (route) => false,
            );
          } else if (index == 1) {
            // NEWS一覧に戻る
            Navigator.pop(context);
          } else if (index == 2) {
            // Facebook
            final url = Uri.parse('https://www.facebook.com/ohyeahmihama');
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else if (index == 3) {
            // Instagram
            final url = Uri.parse('https://www.instagram.com/oh_yeah_mihama/');
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        },
      ),
    );
  }
}