import 'package:flutter/material.dart';

class HomeScreensSearch extends StatelessWidget {
  const HomeScreensSearch(
      {super.key, required this.filterFunc, required this.searchFunc});
  final Function? filterFunc;
  final Function(String)? searchFunc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              filterFunc;
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onChanged: searchFunc,
      ),
    );
  }
}
