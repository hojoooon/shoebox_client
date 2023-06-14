import 'package:flutter/material.dart';
import 'package:shoe_box_client/screen/home_screen.dart';
import 'package:shoe_box_client/screen/profile_screen.dart';
import 'package:shoe_box_client/screen/shoe_closet_screen.dart';
import 'package:shoe_box_client/screen/shop_screen.dart';

class TabInfo {
  final IconData icon;
  final String label;
  final Widget screen;

  const TabInfo({
    required this.icon,
    required this.label,
    required this.screen,
  });
}

List TABS = [
  const TabInfo(
    icon: Icons.home,
    label: '홈',
    screen: HomeScreen(),
  ),
  const TabInfo(
    icon: Icons.shopping_bag_rounded,
    label: '쇼핑',
    screen: ShopScreen(),
  ),
  const TabInfo(
    icon: Icons.all_inbox_rounded,
    label: '신발장',
    screen: ShoeClosetScreen(),
  ),
  const TabInfo(
    icon: Icons.person_rounded,
    label: '프로필',
    screen: ProfileScreen(),
  ),
];
