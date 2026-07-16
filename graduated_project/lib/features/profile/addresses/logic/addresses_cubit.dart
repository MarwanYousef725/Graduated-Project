import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduated_project/features/profile/addresses/data/address_model.dart';
import 'package:graduated_project/features/profile/addresses/logic/addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  AddressesCubit() : super(AddressesInitial());

  void loadAddresses() async {
    emit(AddressesLoading());
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    final addresses = [
      AddressModel(
        id: '1',
        label: 'Home',
        name: 'John Doe',
        detail:
            '123 Green Valley Apartment, Block B\nSunset Boulevard, North Avenue\nNew York, NY 10001',
        phone: '+1 (555) 000-1234',
        isDefault: true,
      ),
      AddressModel(
        id: '2',
        label: 'Office',
        name: 'John Doe (Work)',
        detail:
            'Tech Park East, Suite 405\nSilicon Valley Drive\nPalo Alto, CA 94304',
        phone: '+1 (555) 999-8888',
        isOffice: true,
      ),
    ];

    emit(AddressesLoaded(addresses));
  }

  void deleteAddress(String id) {
    // Implement delete logic
  }
}
