import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  final RemoteMessage? initialMessage;

  const SplashScreen({super.key, this.initialMessage});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _handleStartup();
  }

  Future<void> _handleStartup() async {
    await Future.delayed(const Duration(seconds: 2));

    /// 🔥 ログ（絶対確認）
    print("🔥 initialMessage: ${widget.initialMessage}");
    print("🔥 data: ${widget.initialMessage?.data}");

    /// 🔴 dataがあるかチェック
    final data = widget.initialMessage?.data;

    if (data != null && data.isNotEmpty) {
      final newsId = data['newsId'];

      print("🔥 newsId: $newsId");

      if (newsId != null && newsId.toString().isNotEmpty) {
        navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (_) =>
                NewsDetailPageById(newsId: newsId.toString()),
          ),
        );
        return;
      }
    }

    /// 通常遷移
    navigatorKey.currentState?.pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE0D4), // ←ベージュに統一
      body: Center(
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 500),
          child: const Text(
            "Oh Yeah!",
            style: TextStyle(
              fontFamily: "Impact",
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}