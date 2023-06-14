import 'package:flutter/material.dart';
import 'package:shoe_box_client/const/colors.dart';
import 'package:shoe_box_client/const/tabs.dart';

class InitScreen extends StatefulWidget {
  final String userId;
  const InitScreen({
    required this.userId,
    super.key,
  });

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> with TickerProviderStateMixin {
  late final TabController controller;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(
      length: TABS.length,
      vsync: this,
    );

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('shoeBOX'),
      //   backgroundColor: primaryColor,
      // ),
      body: TabBarView(
        controller: controller,
        children: TABS
            .map((e) => SafeArea(
                  child: e.screen,
                ))
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: TABS
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.icon),
                  label: e.label,
                ))
            .toList(),
        selectedItemColor: primaryColor,
        unselectedItemColor: wireFrameColor,
        currentIndex: controller.index,
        onTap: (value) {
          controller.animateTo(value);
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
