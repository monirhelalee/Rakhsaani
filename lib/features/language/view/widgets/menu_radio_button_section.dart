import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rakhsaani/core/utils/colors.dart';
import 'package:rakhsaani/features/surah_list/view_model/surah_list_view_model.dart';
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
  void initState() {
    StorageManager.getKey('lang').then((value) {
      context.read<LanguageViewModel>().onLanguageSelect(value!);
    });
    super.initState();
  }

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
                      if (!mounted) return;
                      vm.onLanguageSelect(s!);
                      context.read<SurahListViewModel>().fetchSurahList();
                      Fluttertoast.showToast(
                          msg: "$s surah list loaded",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: toastBGColor,
                          textColor: toastTextColor,
                          fontSize: 16.0);
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
