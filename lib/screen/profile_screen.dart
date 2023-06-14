import 'package:flutter/material.dart';
import 'package:shoe_box_client/const/colors.dart';
import 'package:shoe_box_client/screen/puchased_screen.dart';
import '../const/globals.dart' as globals;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();

    userData = globals.Globals.userData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const CircleAvatar(
                backgroundColor: wireFrameColor,
                radius: 40,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                userData!['userName'],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(200, 36),
                ),
                onPressed: () {},
                child: const Text(
                  '프로필 수정',
                  style: TextStyle(color: wireFrameColor),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              rowMenuItem(
                Icons.card_giftcard_rounded,
                '주문 내역',
              ),
              rowMenuDivider(),
              rowMenuItem(
                Icons.event_rounded,
                '이벤트',
              ),
              rowMenuDivider(),
              rowMenuItem(
                Icons.settings,
                '설정',
              )
            ],
          ),
        ),
        Container(
          height: 20,
          color: Colors.grey[100],
        ),
        const Expanded(
          flex: 4,
          child: Column(),
        ),
      ],
    );
  }

  Widget rowMenuItem(IconData icon, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const PurchasedScreen();
          }));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.grey[400],
              size: 32.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowMenuDivider() {
    return VerticalDivider(
      color: Colors.grey[400],
      width: 1,
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }
}
