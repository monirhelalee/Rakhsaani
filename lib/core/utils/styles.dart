import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rakhsaani/core/utils/utils_exports.dart';

class TextStyles {
  static TextStyle title29 = GoogleFonts.exo2(
    fontWeight: FontWeight.w400,
    color: whiteColor,
    fontSize: 29,
  );
  static TextStyle title40 = GoogleFonts.exo2(
    fontWeight: FontWeight.w700,
    color: whiteColor,
    fontSize: 40,
  );
  static final title20 = title29.copyWith(fontSize: 20);
  static final titleYellow20 =
      title29.copyWith(fontSize: 20, color: yellowColor);
  static final regular18 = title29.copyWith(fontSize: 18);
  static final regular16 = title29.copyWith(fontSize: 16);
  static final regularLightGrey17 =
      regular18.copyWith(fontSize: 17, color: lightGreyColor);
  static final regular14 = regular16.copyWith(
    fontSize: 14,
  );
  static final regular12 = regular16.copyWith(
    fontSize: 12,
  );

  static final regularPrimary12 = regular16.copyWith(
      fontSize: 12, color: primaryColor, fontWeight: FontWeight.w500);
  static final regularGrey12 =
      regularPrimary12.copyWith(fontSize: 12, color: greyColor);
  static final regular10 = regular16.copyWith(
    fontSize: 10,
  );
  static final regularGrey13 =
      regular14.copyWith(fontSize: 13, color: greyColor);
}
