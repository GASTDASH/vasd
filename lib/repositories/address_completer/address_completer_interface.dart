abstract class AddressCompleterInterface {
  Future<List<String>> getAddresses(String addressPart);
}
