import 'package:flutter/material.dart';
import 'beranda.dart';
import 'tugas.dart';
import 'notification.dart';
import 'saya.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomNavBar({super.key, required this.selectedIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return;

    Widget page;
    switch (index) {
      case 0:
        page = const Beranda();
        break;
      case 1:
        page = const Tugas();
        break;
      case 2:
        page = const Notifikasi();
        break;
      case 3:
        page = const Saya();
        break;
      default:
        page = const Beranda();
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navBgColor = isDark ? const Color(0XFF1E1E1E) : Colors.white;
    final unselectedIconColor = isDark ? Colors.white54 : Colors.black45;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: navBgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark ? null : [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.cottage_rounded, 0, unselectedIconColor),
          _buildNavItem(context, Icons.menu_book_rounded, 1, unselectedIconColor),
          _buildNavItem(context, Icons.notifications_rounded, 2, unselectedIconColor),
          _buildNavItem(context, Icons.person_rounded, 3, unselectedIconColor),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, int index, Color unselectedColor) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(context, index),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0XFF018592).withOpacity(0.2) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? const Color(0XFF018592) : unselectedColor,
          size: 26,
        ),
      ),
    );
  }
}