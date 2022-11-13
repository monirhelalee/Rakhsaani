import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/features/error_screen/error_screen.dart';
import '../../../../core/helpers/storage_manager.dart';
import '../../view_model/language_view_model.dart';

class MenuRadioButtonSection extends StatefulWidget {
  const MenuRadioButtonSection({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuRadioButtonSection> createState() => _MenuRadioButtonSectionState();
}

class _MenuRadioButtonSectionState extends State<MenuRadioButtonSection> {
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
                      vm.onLanguageSelect(s!);
                      StorageManager().setKey('isFirstTime', 'no');
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
