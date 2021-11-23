import 'package:flutter/material.dart';
import 'package:oshin_list/utils/theme.dart';
import 'package:oshin_list/utils/utils.dart';

class AppPage extends StatelessWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oshin List',
      onGenerateRoute: onGenerateRoute,
      theme: mainTheme,
    );
  }
}
