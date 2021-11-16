import 'package:flutter/material.dart';
import 'package:oshin_list/utils/utils.dart';

class AppPage extends StatelessWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _AppView();
  }
}

class _AppView extends StatelessWidget {
  const _AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oshin List',
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
