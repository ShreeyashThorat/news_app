import 'package:flutter/material.dart';
import 'package:news_app/utils/constant_data.dart';

import '../../../widgets/my_button.dart';

class CategoriesBottomSheet extends StatefulWidget {
  final Function(String) applyCategory;
  final String selectedCategory;
  const CategoriesBottomSheet(
      {super.key, required this.applyCategory, required this.selectedCategory});

  @override
  State<CategoriesBottomSheet> createState() => _CategoriesBottomSheetState();
}

class _CategoriesBottomSheetState extends State<CategoriesBottomSheet> {
  String selectedCategory = "";

  @override
  void initState() {
    setState(() {
      selectedCategory = widget.selectedCategory;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Expanded(
            child: ListView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          children: [
            ...List.generate(ConstantData.categoriesList.length, (index) {
              return ListTile(
                title: Text(ConstantData.categoriesList[index],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                trailing: Checkbox(
                    value:
                        selectedCategory == ConstantData.categoriesList[index].toLowerCase(),
                    side: const BorderSide(width: 1),
                    splashRadius: 0,
                    onChanged: (val) {
                      setState(() {
                        selectedCategory = ConstantData.categoriesList[index].toLowerCase();
                      });
                    }),
              );
            })
          ],
        )),
        Container(
          width: size.width,
          margin:
              EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 5),
          child: MyElevatedButton(
              onPress: () {
                widget.applyCategory(selectedCategory.toLowerCase());
              },
              elevation: 0,
              buttonContent: const Text(
                "Apply",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )),
        )
      ],
    );
  }
}
