import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/features/map/bloc/map_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/map/models/location_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({super.key, required this.location});

  final LocationModel location;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 142,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 24,
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 52,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  location.address,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  context.read<MapBloc>().add(LoadLocationsEvent(location));
                  Navigator.of(context).pop(location);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.maxFinite, 56),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.choose,
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
