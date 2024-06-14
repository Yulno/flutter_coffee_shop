import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/features/menu/models/item_model.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:flutter_coffee_shop/src/theme/image_sources.dart';

class BottomSheetScroll extends StatefulWidget {
  const BottomSheetScroll({super.key, required this.order});

  final Map<ItemModel, int> order;

  @override
  State<BottomSheetScroll> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheetScroll> {
  final List<ItemModel> list = [];
  @override
  void initState() {
    super.initState();
    for (var element in widget.order.entries) {
      for (var i = 0; i < element.value; i++) {
        list.add(element.key);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return BottomSheetTile(
          item: list[index],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 10,
        );
      },
      itemCount: list.length,
    );
  }
}

class BottomSheetTile extends StatelessWidget {
  const BottomSheetTile({super.key, required this.item});
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: item.icon,
        placeholder: (context, url) => const Center(
          child: SizedBox.shrink(),
        ),
        errorWidget: (context, url, error) =>
            Image.asset(ImageSources.coffeeIcon),
        fit: BoxFit.contain,
        width: 55,
      ),
      title: Text(
        item.name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: Text(
        "${item.price} ₽",
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColors.black),
      ),
    );
  }
}
