import 'package:flutter/material.dart';

class WeatherInfoContainer extends StatelessWidget {
  final String description;
  final Icon icon;
  final String data;

  const WeatherInfoContainer(
      {super.key,
      required this.description,
      required this.data,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.white, width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: icon,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          description,
          style: TextStyle(
            color: Colors.white,
            fontSize: isTablet ? 25 : 15,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          data,
          style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 30 : 20,
              letterSpacing: 1.5),
        ),
      ],
    );
  }
}
