import 'package:flutter/material.dart';

class CustomCompletedOrNot extends StatelessWidget {
  const CustomCompletedOrNot({
    super.key,
    required this.number,
    required this.icon,
    required this.state,
  });
  final int number;
  final String icon;
  final String state;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.008,
          vertical: MediaQuery.of(context).size.height * 0.008,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              MediaQuery.of(context).size.width *
                  (16 / MediaQuery.of(context).size.width),
            ),
          ),
          color: const Color(0xfff9ecf0),
        ),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.030),
                  Text('$number'),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.030),
                  Image.asset(
                    icon,
                    width: MediaQuery.of(context).size.width * 0.050,
                    height: MediaQuery.of(context).size.height * 0.050,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.005),
                  Text(
                    state,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaler.scale(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
