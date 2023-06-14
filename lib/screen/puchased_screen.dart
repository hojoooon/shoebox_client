import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shoe_box_client/const/globals.dart';
import 'package:shoe_box_client/screen/login_screen.dart';

class PurchasedScreen extends StatefulWidget {
  const PurchasedScreen({super.key});

  @override
  State<PurchasedScreen> createState() => _PurchasedScreenState();
}

class _PurchasedScreenState extends State<PurchasedScreen> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: "ko_KR");
  bool? isSatisfied = true;

  Future<void> sizeFeedback(BuildContext context) async {
    // Call the login API
    final success =
        await apiService.sizeFeedback(Globals.userData['userId'], 'nike', 285);

    if (success == true) {
      // Navigate to the next screen after successful login
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('감사합니다!'),
            content: const Text('추천 받은 사이즈가 적용되었습니다.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // Show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      SizedBox(
                        height: 60,
                        child: Text(
                          '주문 내역',
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        color: Colors.grey[300],
                        height: 40,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('구매  2023.06.14 16:45'),
                              Row(
                                children: [
                                  Text('주문내역상세'),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              'https://image.a-rt.com/art/product/2023/01/75699_1674199056451.jpg?shrink=590:590',
                              fit: BoxFit.cover,
                              width: 120,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${Globals.shoesData['nike'][174]['shoesName']}',
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  '사이즈: 285',
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  '${Globals.shoesData['nike'][174]['brand']}',
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  formatCurrency.format(
                                      Globals.shoesData['nike'][174]['price']),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('추천 사이즈를 평가해주세요.'),
                                    content:
                                        const Text('추천 받으신 사이즈(285)가 맞으셨나요?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('안 맞았어요'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('맞았어요!'),
                                        onPressed: () {
                                          sizeFeedback(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text('사이즈 평가'),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
