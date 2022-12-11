import 'package:flutter/material.dart';
import '../../../../core/utils/colors.dart';

class Separator extends StatelessWidget {
  const Separator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Divider(color: primaryColor,),
    );
  }
}