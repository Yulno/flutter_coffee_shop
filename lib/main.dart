import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/common/network/api.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/bloc_observer.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/menu_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/app.dart';

void main() {
  Bloc.observer = const Observer();
  final menuRepository = MenuRepositoryImpl(api: Api(), dio: Dio());
  runZonedGuarded(
      () => runApp(RepositoryProvider.value(
          value: menuRepository,
          child: const CoffeeShopApp(),),), (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}
