import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Divider(),
    );
  }
}