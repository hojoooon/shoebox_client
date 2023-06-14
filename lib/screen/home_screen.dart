import 'package:flutter/material.dart';
import 'package:shoe_box_client/components/product_card.dart';
import '../const/globals.dart' as globals;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userData = globals.Globals.userData;
  Map<String, dynamic>? shoesData = globals.Globals.shoesData;
  final List<Map<String, dynamic>> popularProducts = [];
  List<Map<String, dynamic>> recomProducts = [];

  @override
  void initState() {
    super.initState();

    popularProducts.addAll(
      [
        shoesData!['adidas'][54],
        shoesData!['nike'][31],
        shoesData!['adidas'][91],
        shoesData!['converse'][14],
        shoesData!['vans'][10],
        shoesData!['nike'][19],
        shoesData!['newBalance'][43],
      ],
    );

    recomProducts.addAll(
      [
        shoesData!['nike'][20],
        shoesData!['adidas'][14],
        shoesData!['newBalance'][54],
        shoesData!['adidas'][51],
        shoesData!['nike'][13],
        shoesData!['vans'][47],
        shoesData!['newBalance'][13],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            Row(
              children: [
                SizedBox(
                  height: 60,
                  child: Text(
                    '${userData!['userName']}님, 활기찬 하루 보내세요!',
                    style: const TextStyle(fontSize: 28),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '인기 상품',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '더보기',
                        ),
                        Icon(
                          Icons.add,
                          size: 10,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 300,
                  child: ListView(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: popularProducts.map((e) {
                        return ProductCard(
                          shoesName: e['shoesName'],
                          shoesImg: e['shoesImg'],
                          brand: e['brand'],
                          price: e['price'],
                        );
                      }).toList()),
                )
              ],
            ),
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '맞춤 상품',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '더보기',
                        ),
                        Icon(
                          Icons.add,
                          size: 10,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 300,
                  child: ListView(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: recomProducts.map((e) {
                      return ProductCard(
                        shoesName: e['shoesName'],
                        shoesImg: e['shoesImg'],
                        brand: e['brand'],
                        price: e['price'],
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
