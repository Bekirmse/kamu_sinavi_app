import 'package:flutter/material.dart';

import 'package:kamu_sinavi_app/theme.dart';

class SubjectItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  const SubjectItem({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 170,
          width: 160,
          color: whiteColor,
          padding: const EdgeInsets.all(10), // Add padding for better spacing
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center align items vertically
            children: [
              Image.asset(
                imageUrl,
                width: 80,
              ),
              const SizedBox(height: 8),
              Text(
                name,
                textAlign: TextAlign.center, // Center align text
                style: blackTextStyle.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 4),

              const SizedBox(height: 10),
              // Optional: Uncomment this if you want to show additional info
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/star.png',
                    width: 20,
                  ),
                  const Text(' 1000 soru') // Added space for better readability
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
