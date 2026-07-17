import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduated_project/core/theme/app_colors.dart';
import 'package:graduated_project/features/profile/addresses/logic/addresses_cubit.dart';
import 'package:graduated_project/features/profile/addresses/logic/addresses_state.dart';
import 'package:graduated_project/features/profile/addresses/ui/widgets/address_card.dart';

class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressesCubit()..loadAddresses(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.textDark,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Saved Addresses',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: BlocBuilder<AddressesCubit, AddressesState>(
          builder: (context, state) {
            if (state is AddressesLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(5, 150, 105, 1),
                ),
              );
            } else if (state is AddressesLoaded) {
              return Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      ...state.addresses.map(
                        (address) => AddressCard(
                          address: address,
                          onEdit: () {},
                          onDelete: () => context
                              .read<AddressesCubit>()
                              .deleteAddress(address.id),
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                  Positioned(
                    bottom: 24,
                    left: 20,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryTeal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.add, size: 24),
                          SizedBox(width: 8),
                          Text(
                            'Add New Address',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is AddressesError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
