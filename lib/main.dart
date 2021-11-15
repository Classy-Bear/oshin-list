import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:oshin_list/app.dart';
import 'package:oshin_list/bloc_observer.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}
