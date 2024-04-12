import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/cart/cart_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/menu/menu_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/menu_repository.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/menu_screen.dart';
import 'package:flutter_coffee_shop/src/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
      theme: theme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CartBloc(context.read<MenuRepositoryImpl>()),
          ),
          BlocProvider(
            create: (context) => MenuBloc(context.read<MenuRepositoryImpl>(),),
                    ),
          
        ],
        child: const MenuScreen(),
      ),
    );
  }
}