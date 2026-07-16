class AddressModel {
  final String id;
  final String label;
  final String name;
  final String detail;
  final String phone;
  final bool isDefault;
  final bool isOffice;

  AddressModel({
    required this.id,
    required this.label,
    required this.name,
    required this.detail,
    required this.phone,
    this.isDefault = false,
    this.isOffice = false,
  });
}
