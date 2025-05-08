import 'package:flutter/material.dart';

class BottomNavbarItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final bool isActive;
  final VoidCallback onTap; // Tıklama olayını tanımlayın

  const BottomNavbarItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.isActive,
    required this.onTap, // OnTap'ı zorunlu hale getirin
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Tıklama olayını işleyin
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imageUrl,
            width: 24,
            height: 24,
            color: isActive
                ? Colors.blue
                : Colors.grey, // Aktifse mavi, değilse gri
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
