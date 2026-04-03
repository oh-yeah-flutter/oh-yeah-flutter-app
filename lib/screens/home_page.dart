import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onMapTap;

  const HomePage({
    super.key,
    required this.onMenuTap,
    required this.onMapTap,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _initFCM();
  }

  Future<void> _initFCM() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea( // ← Scaffoldは絶対使わない
      child: Column(
        children: [

          /// 🔥 ヘッダー
          Container(
            width: double.infinity,
            height: 120,
            color: const Color(0xFF45290a),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),

          /// 🔥 コンテンツ
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('slider_images')
                  .orderBy('order')
                  .snapshots(),
              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final docs = snapshot.data!.docs;

                return SingleChildScrollView(
                  child: Column(
                    children: [

                      const SizedBox(height: 20),

                      /// 🔥 スライダー
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 260,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            setState(() => _current = index);
                          },
                        ),
                        items: docs.map((doc) {
                          final data =
                              doc.data() as Map<String, dynamic>;

                          return ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: data['imageUrl'],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                      ),

                      /// 🔥 ドット
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: docs
                            .asMap()
                            .entries
                            .map((entry) {
                          return Container(
                            width: 8,
                            height: 8,
                            margin:
                                const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current ==
                                      entry.key
                                  ? Colors.brown
                                  : Colors.brown
                                      .withValues(
                                          alpha: 0.3),
                            ),
                          );
                        }).toList(),
                      ),

                      /// 🔥 ボタン
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(
                                horizontal: 20),
                        child: Row(
                          children: [
                            _button(
                                Icons.restaurant_menu,
                                'MENU',
                                widget.onMenuTap),
                            const SizedBox(width: 15),
                            _button(Icons.map, 'MAP',
                                widget.onMapTap),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(
      IconData icon,
      String text,
      VoidCallback onTap) {
    return Expanded(
      child: Material(
        color: const Color(0xFF3E2723),
        borderRadius:
            BorderRadius.circular(15),
        child: InkWell(
          onTap: onTap,
          borderRadius:
              BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 22),
            child: Column(
              children: [
                Icon(icon,
                    color: Colors.white,
                    size: 30),
                const SizedBox(height: 8),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}