import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/features/menu/bloc/order/order_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_coffee_shop/src/features/menu/view/widgets/menu_list.dart';

class OrderBottomSheet extends StatelessWidget {
  const OrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold( body:  Padding(
        padding:
            const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.yourOrder,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                IconButton(
                  onPressed: () {
                    context.read<OrderBloc>()
                        .add(const DeleteOrder());
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: BottomSheetScroll(
                order: context.watch<OrderBloc>().state.orderProducts,
              ),
            ),
            BlocListener<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state.status == OrderStatus.success) {
                  context.read<OrderBloc>().add(
                        const DeleteOrder(),
                      );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text(
                        AppLocalizations.of(context)!.success,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  );
                }
                if (state.status == OrderStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 2),
                      content: Text(
                        AppLocalizations.of(context)!.error,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  );
                }
              },
              child: ElevatedButton(
                onPressed: () {
                  context.read<OrderBloc>().add(const PostOrder());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.maxFinite, 56),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.order,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
        
          ],
        ),
      ),
      
      
      
      
    );
  }
}
