import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.warning_rounded,
            color: Colors.grey,
            size: 50,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Something Went Wrong',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Please check your internet connection &\nTry again',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
