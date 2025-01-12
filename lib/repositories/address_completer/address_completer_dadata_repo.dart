import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vasd/repositories/address_completer/address_completer.dart';

class AddressCompleterDadataRepo implements AddressCompleterInterface {
  @override
  Future<List<String>> getAddresses(String addressPart) async {
    var res = await GetIt.I<Dio>().get(
      "http://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Token 10602227c58e24eae6ba5dd9f6640f9225ca64fc",
        },
      ),
      queryParameters: {"query": addressPart},
    );

    List<String> addresses = (res.data["suggestions"] as List<dynamic>)
        .map(
          (entry) => (entry as Map<String, dynamic>)["value"].toString(),
        )
        .toList();

    return addresses;
  }
}
