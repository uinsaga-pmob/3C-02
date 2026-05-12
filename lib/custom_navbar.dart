import 'package:flutter/material.dart';
import 'beranda.dart';
import 'tugas.dart';
import 'notification.dart';
import 'saya.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomNavBar({super.key, required this.selectedIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return; // Jangan pindah jika sudah di halaman tersebut

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
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0XFF1E1E1E),
        borderRadius: BorderRadius.circular(20), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.cottage_rounded, 0),
          _buildNavItem(context, Icons.menu_book_rounded, 1),
          _buildNavItem(context, Icons.notifications_rounded, 2),
          _buildNavItem(context, Icons.person_rounded, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(context, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0XFF015E67).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 28,
          color: isSelected ? const Color(0XFF018592) : const Color(0XFFEDEDED).withOpacity(0.5),
        ),
      ),
    );
  }
}