import 'package:flutter/material.dart';
import 'package:weatherapp/utils/colors.dart';

class SearchHistoryContainer extends StatelessWidget {
  final String cityName;
  final String imageUrl;
  final String temperature;
  final String description;

  const SearchHistoryContainer({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Colors.white70)),
        padding: EdgeInsets.all(isTablet ? 32 : 16),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cityName,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: whiteColor),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: whiteColor,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      temperature,
                      style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: whiteColor),
                    ),
                    const Text(
                      "°C",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: whiteColor),
                    ),
                  ],
                ),
                Image.network(
                  imageUrl,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  description,
                  style: const TextStyle(fontSize: 22, color: whiteColor
                      //fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
