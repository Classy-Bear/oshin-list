import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {

  final Function(String) onTextChanged;
  final String title;
  final String? searchInputPlaceHolder;

  /// Creates the AppBar with the search, is necesary tu call it inside of a [PreferredSize] widget
  const SearchAppBar({
    Key? key,
    required this.onTextChanged,
    required this.title,
    this.searchInputPlaceHolder,
  }) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool searchMode = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      actions: searchBarButtons(),
      backgroundColor: searchMode ? Colors.white : Colors.blue,
      title: searchMode ? appBarTextField() : appBarTitle(),
    );
  }

  Widget appBarTextField() {
    return TextField(
      onChanged: (text) => widget.onTextChanged(text),
      maxLines: 1,
      decoration: InputDecoration(
        hintText: widget.searchInputPlaceHolder,
        constraints: const BoxConstraints(maxHeight: 50),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue)),
        enabled: true,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.blue,
          width: 4,
        )),
      ),
    );
  }

  List<Widget> searchBarButtons() {
    return [
      IconButton(
        onPressed: () {
          setState(() {
            searchMode = !searchMode;
          });
        },
        icon: !searchMode
            ? const Icon(Icons.search)
            : const Icon(Icons.cancel_outlined),
        color: !searchMode ? Colors.white : Colors.blue,
      )
    ];
  }

  Widget appBarTitle() {
    return Text(
      widget.title,
      style: const TextStyle(color: Colors.white),
    );
  }
}
