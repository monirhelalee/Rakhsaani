import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/helpers/storage_manager.dart';
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
      child: Consumer<LanguageViewModel>(
        builder: (context, vm, _) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: vm.languageModel.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Radio(
                    value: vm.languageModel[index].name,
                    groupValue: vm.selectedLanguage,
                    onChanged: (s) async {
                      await StorageManager.setKey('lang', s);
                      await StorageManager.setKey('isFirstTime', 'no');
                      vm.onLanguageSelect(s!);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (c) {
                            return const SurahListScreen();
                          },
                        ),
                      );
                    },
                  ),
                  Text(vm.languageModel[index].name),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
