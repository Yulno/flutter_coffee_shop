import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/features/map/bloc/map_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/map/view/map_screen.dart';
import 'package:flutter_coffee_shop/src/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state.status == MapStatus.idle) {
          final currentLocation = state.currentLocation;
          return SizedBox(
            height: 40,
            child: currentLocation != null
                ? InkWell(
                    onTap: () => {_toMapScreen(context)},
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8, right: 10),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: AppColors.blue,
                            size: 24,
                          ),
                        ),
                        Text(
                          currentLocation.address,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                : InkWell(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.blue,
                          size: 24,
                        ),
                        Text(
                          AppLocalizations.of(context)!.noLocation,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Future<void> _toMapScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<MapBloc>(),
          child: const MapScreen(),
        ),
      ),
    );
  }
}
