import 'package:flutter/material.dart';
import 'package:rakhsaani/core/utils/colors.dart';
import 'package:rakhsaani/core/utils/constant.dart';
import 'package:rakhsaani/core/utils/styles.dart';
import 'package:rakhsaani/core/widgets/common_text_widget.dart';

class AboutRakhsaani extends StatelessWidget {
  const AboutRakhsaani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: CommonTextWidget("About", style: AppTextStyles.title20),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight / 2.3,
            width: screenWidth,
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_image_about.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/icons/logo.png",
                      height: 80,
                    ),
                  ],
                ),
                CommonTextWidget(
                  "My Lord,",
                  style: AppTextStyles.title40,
                ),
                CommonTextWidget(
                  "Increase Me In",
                  style: AppTextStyles.title29.copyWith(fontSize: 24),
                ),
                CommonTextWidget(
                  "Knowledge.",
                  style: AppTextStyles.title29.copyWith(fontSize: 30),
                ),
                spaceBetween,
                Row(
                  children: [
                    spaceAround,
                    spaceAround,
                    spaceAround,
                    spaceAround,
                    CommonTextWidget(
                      " - Surah Taha(20:14)",
                      style: AppTextStyles.regular12,
                    ),
                  ],
                ),
              ],
            ),
          ),
          spaceBetween,
          spaceBetween,
          spaceBetween,
          Column(
            children: [
              CommonTextWidget(
                "About Rakhasaani Trust",
                style: AppTextStyles.regular18.copyWith(fontSize: 24),
              ),
              spaceBetween,
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: CommonTextWidget(
                  "To disseminate the message of The Holy Quran to diverse people irrespective of race, culture, religion, muslim/ non-muslim crosswise the global in their native language for the clear understanding of intense and accurate meaning of Quran and simultaneously promote harmonious relations for communal peace and goodwill so that people can recognize the dissimilar aspects of it and resolve any conflicts that aries by establishing goodness and virtues.",
                  textAlign: TextAlign.justify,
                  style: AppTextStyles.regular16,
                ),
              ),
              spaceBetween,
              spaceBetween,
              spaceBetween,
              CommonTextWidget(
                "www.rakhsaanitrust.org",
                style: AppTextStyles.regular14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
