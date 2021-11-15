import 'package:flutter/material.dart';
import 'package:oshin_list/core/widgets/serch_app_bar/search_app_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SearchAppBar(
          onTextChanged: (text) {
            debugPrint(text);
          },
          title: 'Oshin Tasklist',
          searchInputPlaceHolder: 'search you task',
        ),
      ),
      body: Center(
        child: Container(
          color: Colors.red,
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}
