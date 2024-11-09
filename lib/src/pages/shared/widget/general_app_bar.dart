import 'package:flutter/material.dart';

import 'search_box.dart';

class GeneralAppBar extends StatelessWidget {
  final void Function() onSearch;
  final void Function() onShowFilter;
  final void Function() onChangeLanguage;
  final TextEditingController searchTitleController;
  GeneralAppBar({
    required this.onSearch,
    required this.onShowFilter,
    required this.onChangeLanguage,
    required this.searchTitleController,
  });

  @override
  Widget build(BuildContext context) => AppBar(
        title: SearchBox(onSearch: onSearch,controller: searchTitleController,),
        leading: IconButton(
          icon: Icon(
            Icons.filter_alt,
            color: Colors.grey.shade500,
            size: 24,
          ),
          onPressed:onShowFilter,
        ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.language_outlined,
          color: Colors.grey.shade500,
          size: 24,
        ),
        onPressed:onChangeLanguage,
      )
    ],
      );
}
