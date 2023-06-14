import 'package:flutter/material.dart';
import 'package:shoe_box_client/const/colors.dart';
import 'package:shoe_box_client/screen/login_screen.dart';
import '../const/globals.dart' as globals;

class ShoeClosetScreen extends StatefulWidget {
  const ShoeClosetScreen({super.key});

  @override
  State<ShoeClosetScreen> createState() => _ShoeClosetScreenState();
}

class _ShoeClosetScreenState extends State<ShoeClosetScreen> {
  Map<String, dynamic>? userData = globals.Globals.userData;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  TextStyle cardTextStyle = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: primaryColor);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 48,
              ),
              Row(
                children: [
                  Text(
                    '${userData!['userName']}님을 위한 ',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const Text(
                    '추천 사이즈',
                    style: TextStyle(
                        fontSize: 24,
                        color: primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              brandSizeCard('nike'),
              const SizedBox(height: 8),
              brandSizeCard('adidas'),
              const SizedBox(height: 8),
              brandSizeCard('newBalance'),
              const SizedBox(height: 8),
              brandSizeCard('vans'),
              const SizedBox(height: 8),
              brandSizeCard('converse'),
              const SizedBox(
                height: 16.0,
              ),
              Card(
                child: Image.network(
                  'https://kream-phinf.pstatic.net/MjAyMzA2MDlfMjYx/MDAxNjg2MjgwNTQ4MDc3.iox2GeTI3xFoEm56h_zu_NDtd1a17ntp-o-bYm4H2y8g.BqlNNhk1QoTXNCFU9qDy8d4Ng2CyswZUrKpv5hqkiKEg.JPEG/a_cc6b9d5bcbcc44aaa55969b0e29505a6.jpg?type=m_2560_webp',
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget brandSizeCard(String brand) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(
                  'asset/img/$brand.png',
                  width: 80,
                  height: 40,
                ),
              ],
            ),
            if (userData!['shoesSizes'][brand] != null)
              Center(
                child: Text(
                  '${userData!['shoesSizes'][brand].toString().split('.')[0]}mm',
                  style: cardTextStyle,
                ),
              )
            else if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            else
              TextButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await apiService.recommendPost(userData!['userId'], brand);
                  setState(() {
                    userData = globals.Globals.userData;
                    isLoading = false;
                  });
                },
                child: Text(
                  '추천 받기',
                  style: cardTextStyle.copyWith(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
