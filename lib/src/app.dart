import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/features/map/bloc/map_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/map/data/data_sourses/locations_data_sourse.dart';
import 'package:flutter_coffee_shop/src/features/map/data/data_sourses/savable_locations_data_sourses.dart';
import 'package:flutter_coffee_shop/src/features/map/data/map_repository.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/order/order_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/menu/menu_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/order_repository.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/item_repository.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/category_repository.dart';
import 'package:flutter_coffee_shop/src/common/data_base/database.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/items_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/order_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/savable_categories_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/data/data_sources/savable_items_data_source.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/menu_screen.dart';
import 'package:flutter_coffee_shop/src/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  static final dio = Dio(
    BaseOptions(baseUrl: 'https://coffeeshop.academy.effective.band/api/v1'),
  );
  static final db = AppDatabase();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ILocationsRepository>(
          create: (context) => LocationsRepository(
            networkLocationsDataSource:
                NetworkLocationsDataSource(dio: dio),
            dbLocationsDataSource: DbLocationsDataSource(db: db),
          ),
        ),
        RepositoryProvider<IOrderRepository>(
          create: (context) => OrderRepository(
            networkOrderDataSource: NetworkOrdersDataSource(dio: dio),
          ),
        ),
        RepositoryProvider<ICategoriesRepository>(
          create: (context) => CategoriesRepository(
            networkCategoriesDataSource: NetworkCategoriesDataSource(dio: dio),
            dbCategoriesDataSource: DbCategoriesDataSource(db: db),
          ),
        ),
        RepositoryProvider<IItemsRepository>(
          create: (context) => ItemsRepository(
            networkItemsDataSource: NetworkItemsDataSource(dio: dio),
            dbItemsDataSource: DbItemsDataSource(db: db),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (context) => AppLocalizations.of(context)!.title,
        theme: theme,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => OrderBloc(context.read<IOrderRepository>()),
            ),
            BlocProvider(
              create: (context) => MenuBloc(
                context.read<IItemsRepository>(),
                context.read<ICategoriesRepository>(),
                
              )..add(
                  const LoadCategoryEvent(),
                ),
            ),
            BlocProvider(
              create: (context) => MapBloc(context.read<ILocationsRepository>(),)
                ..add(const LoadMapEvent()),
            ),
          ],
          child: const MenuScreen(),
        ),
      ),
    );
  }
}
