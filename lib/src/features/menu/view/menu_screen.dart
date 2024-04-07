import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/cart/cart_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/menu/menu_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/widgets/bottomsheet.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/widgets/category.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late String selectedCategoryName;
  final ItemScrollController _menuController = ItemScrollController();
  final ItemScrollController _appBarController = ItemScrollController();
  late ItemPositionsListener itemListener;
  int current = 0;
  bool inProgress = false;
  bool scrolledToBottom = false;

  @override
  void initState() {
    super.initState();
    itemListener = ItemPositionsListener.create();
    itemListener.itemPositions.addListener(() {
      final fullVisible = itemListener.itemPositions.value.firstWhere((item) {
        return item.itemLeadingEdge >= 0;
      }).index;

      if (((fullVisible != current) && inProgress != true) &&
          scrolledToBottom == false) {
        setCurrent(fullVisible);
        appBarScrollToCategory(fullVisible);
      }

      if (scrolledToBottom) {
        context.read<MenuBloc>().add(const LoadPageEvent());
      }
    });
  }

  void setCurrent(int newCurrent) {
    setState(() {
      current = newCurrent;
    });
  }

  void menuScrollToCategory(int ind) async {
    inProgress = true;
    _menuController.scrollTo(
      index: ind,
      duration: const Duration(milliseconds: 200),
    );
    await Future.delayed(
      const Duration(milliseconds: 200),
    );
    inProgress = false;
  }

  void appBarScrollToCategory(int ind) async {
    _appBarController.scrollTo(
      curve: Curves.easeOut,
      opacityAnimationWeights: [20, 20, 60],
      index: ind,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      buildWhen: (context, state) {
        return state.status == MenuStatus.idle;
      },
      builder: (context, state) {
        if (state.status != MenuStatus.error) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                surfaceTintColor: Colors.transparent,
                title: PreferredSize(
                  preferredSize: const Size.fromHeight((40)),
                  child: SizedBox(
                    height: 40,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _appBarController,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<MenuBloc>().state.categories![index];
                              setCurrent(index);
                              menuScrollToCategory(index);
                              appBarScrollToCategory(index);
                            },
                            style: ElevatedButton.styleFrom(
                              shadowColor: AppColors.transparent,
                              backgroundColor: index == current
                                  ? AppColors.blue
                                  : AppColors.white,
                            ),
                            child: Text(
                              state.categories![index].categoryName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: index == current
                                        ? AppColors.white
                                        : AppColors.black,
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ScrollablePositionedList.builder(
                  itemScrollController: _menuController,
                  itemPositionsListener: itemListener,
                  itemBuilder: (context, index) {
                    final category = state.categories![index];
                    final cards = state.items!
                        .where((e) => e.category.id == category.id)
                        .toList();
                    return Category(
                      category: category,
                      cards: cards,
                    );
                  },
                  itemCount: state.categories!.length,
                ),
              ),
              floatingActionButton: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state.cartItems.isNotEmpty) {
                    return FloatingActionButton(
                      backgroundColor: AppColors.blue,
                      onPressed: () => {
                        showModalBottomSheet<dynamic>(
                          backgroundColor: AppColors.white,
                          context: context,
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<CartBloc>(context),
                            child: const CartBottomSheet(),
                          ),
                        ),
                      },
                      child: const Icon(
                        Icons.local_mall,
                        color: AppColors.white,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
