import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/helpers/storage_manager.dart';
import '../../view_model/language_view_model.dart';

class MenuRadioButtonSection extends StatelessWidget {
  const MenuRadioButtonSection({
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
                            onChanged: (s) async {
                              lang.onLanguageSelect(s!);
                              StorageManager().setKey('isFirstTime', 'no');
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
