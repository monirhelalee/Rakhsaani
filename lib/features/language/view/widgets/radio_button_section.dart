import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../surah_list/view/surah_list_screen.dart';
import '../../view_model/language_view_model.dart';

class RadioButtonSection extends StatelessWidget {
  const RadioButtonSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            ['Bengali', 'English', 'Japanese', 'Russian', 'Spanish', 'Nepali']
                .map(
                  (e) => Consumer<LanguageViewModel>(
                    builder: (context, lang, _) {
                      return Row(
                        children: [
                          Radio(
                            value: e,
                            groupValue: lang.selectedLanguage,
                            onChanged: (s) {
                              lang.onLanguageSelect(s!);
                              Future.delayed(Duration(seconds: 3));
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (c) {
                                    return const SurahListScreen();
                                  },
                                ),
                              );
                            },
                          ),
                          Text(e),
                        ],
                      );
                    },
                  ),
                )
                .toList(),
      ),
    );
  }
}
