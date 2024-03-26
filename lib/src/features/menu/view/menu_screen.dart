import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/cart/cart_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/coffee_title_model.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/widgets/bottomsheet.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/widgets/category.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuScreen extends StatefulWidget {
  final List<CategoryModel> categories;

  const MenuScreen({super.key, required this.categories});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Map<String, GlobalKey> categoryKeys;
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

    categoryKeys = {
      for (var category in widget.categories) category.categoryName: GlobalKey(),
    };

    itemListener.itemPositions.addListener(() {
      final fullVisible = itemListener.itemPositions.value.firstWhere((item) {
        return item.itemLeadingEdge >= 0;
      }).index;

      if (((fullVisible != current) && inProgress != true) &&
          scrolledToBottom == false) {
        setCurrent(fullVisible);
        appBarScrollToCategory(fullVisible);
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
        index: ind, duration: const Duration(milliseconds: 200),);
    await Future.delayed(const Duration(milliseconds: 200),);
    inProgress = false;
  }

  void appBarScrollToCategory(int ind) async {
    _appBarController.scrollTo(
        curve: Curves.easeOut,
        opacityAnimationWeights: [20, 20, 60],
        index: ind,
        duration: const Duration(milliseconds: 300),);
  }

  @override
  Widget build(BuildContext context) {
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
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  final category = widget.categories[index];
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: ElevatedButton(
                      onPressed: () {
                        setCurrent(index);
                        menuScrollToCategory(index);
                        appBarScrollToCategory(index);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: index == current
                              ? AppColors.blue
                              : AppColors.white,),
                      child: Text(
                        category.categoryName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
              final category = widget.categories[index];
              return Category(
                key: categoryKeys[category.categoryName],
                category: category,
              );
            },
            itemCount: widget.categories.length,
          ),
        ),
        floatingActionButton: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.status == CartStatus.filled) {
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
            return Container();
          },
        ),
      ),
    );
  }
}
