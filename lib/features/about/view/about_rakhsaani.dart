import 'package:flutter/material.dart';
import 'package:rakhsaani/core/widgets/common_text_widget.dart';

class AboutRakhsaani extends StatelessWidget {
  const AboutRakhsaani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonTextWidget("About"),
      ),
    );
  }
}
