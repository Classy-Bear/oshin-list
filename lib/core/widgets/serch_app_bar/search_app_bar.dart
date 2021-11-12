import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {
  final Function(String) onTextChanged;
  final String title;
  final String? searchInputPlaceHolder;

  /// Creates an AppBar with the search, is necesary to call it inside of a [PreferredSize] widget
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
      actions: [
        _AppBarButtons(
          searchMode: searchMode,
          onModeChanged: (isSearchMode) {
            setState(() {
              searchMode = isSearchMode;
            });
          },
        )
      ], //searchBarButtons(),
      backgroundColor: searchMode ? Colors.white : Colors.blue,
      title: searchMode
          ? _AppBarTextField(
              onTextChanged: (text) => widget.onTextChanged(text),
              searchInputPlaceHolder: widget.searchInputPlaceHolder ?? '',
            )
          : appBarTitle(),
    );
  }

  //it's just a text field
  Widget appBarTitle() {
    return Text(
      widget.title,
      style: const TextStyle(color: Colors.white),
    );
  }
}

class _AppBarButtons extends StatelessWidget {
  bool searchMode;
  final Function(bool) onModeChanged;

  _AppBarButtons({
    Key? key,
    required this.searchMode,
    required this.onModeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        searchMode = !searchMode;
        onModeChanged(searchMode);
      },
      icon: !searchMode
          ? const Icon(Icons.search)
          : const Icon(Icons.cancel_outlined),
      color: !searchMode ? Colors.white : Colors.blue,
    );
  }
}

class _AppBarTextField extends StatelessWidget {
  final Function(String) onTextChanged;
  final String searchInputPlaceHolder;

  const _AppBarTextField({
    Key? key,
    required this.searchInputPlaceHolder,
    required this.onTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) => onTextChanged(text),
      maxLines: 1,
      decoration: InputDecoration(
        hintText: searchInputPlaceHolder,
        constraints: const BoxConstraints(maxHeight: 50),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 4,
          ),
        ),
      ),
    );
  }
}
