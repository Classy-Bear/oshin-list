import 'dart:async';

import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {
  final Function(String) onTextChanged;
  final VoidCallback onSearchClosed;
  final String title;
  final String? searchInputPlaceHolder;

  /// Creates an AppBar with a search functionality.
  ///
  /// **Note**: It's necesary to call it inside of a [PreferredSize] widget.
  const SearchAppBar({
    Key? key,
    required this.onTextChanged,
    required this.title,
    required this.onSearchClosed,
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
              searchMode = !isSearchMode;
            });

            if (!searchMode) {
              widget.onSearchClosed();
            }
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

  Widget appBarTitle() {
    return Text(
      widget.title,
      style: const TextStyle(color: Colors.white),
    );
  }
}

class _AppBarButtons extends StatefulWidget {
  final bool searchMode;
  final Function(bool) onModeChanged;

  const _AppBarButtons({
    Key? key,
    required this.searchMode,
    required this.onModeChanged,
  }) : super(key: key);

  @override
  State<_AppBarButtons> createState() => _AppBarButtonsState();
}

class _AppBarButtonsState extends State<_AppBarButtons> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        widget.onModeChanged(widget.searchMode);
      },
      icon: !widget.searchMode
          ? const Icon(Icons.search)
          : const Icon(Icons.cancel_outlined),
      color: !widget.searchMode ? Colors.white : Colors.blue,
    );
  }
}

class _AppBarTextField extends StatelessWidget {
  final Function(String) onTextChanged;
  final String searchInputPlaceHolder;

  _AppBarTextField({
    Key? key,
    required this.searchInputPlaceHolder,
    required this.onTextChanged,
  }) : super(key: key);

  Timer? timer = Timer(const Duration(seconds: 2), () {});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        if (timer?.isActive ?? false) {
          timer!.cancel();
        }

        timer = Timer(const Duration(milliseconds: 400), () {
          onTextChanged(text);
        });
      },
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
