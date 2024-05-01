import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee_shop/src/features/map/bloc/map_bloc_bloc.dart';
import 'package:flutter_coffee_shop/src/features/map/models/location_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddresesList extends StatelessWidget {
  final List<LocationModel> addresses;

  const AddresesList({super.key, required this.addresses});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  height: 52,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 24),
                        child: InkWell(
                          child: const Icon(
                            Icons.arrow_back,
                            size: 20,
                          ),
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.ourShops,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          addresses[index].address,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                        onTap: () {
                          context.read<MapBloc>().add(
                                LoadLocationsEvent(addresses[index]),
                              );
                          Navigator.of(context).pop(addresses[index]);
                        },
                      ),
                    );
                  },
                  itemCount: addresses.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
