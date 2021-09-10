import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loja/models/cepaberto_address.dart';

const token = '6b2dbddb3c973d884b61cb99b4f163d9';

class CepAbertoService {
  Future<CepAbertoAdress> getAdressFromCEP(String cep) async {
    final cleancep = cep.replaceAll('.', '').replaceAll('-', '');

    final endpint = "https://www.cepaberto.com/api/v3/cep?cep=$cleancep";

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final respnse = await dio.get<Map<String, dynamic>>(endpint);

      if (respnse.data.isEmpty) {
        return Future.error('CEP inválido');
      }
      return CepAbertoAdress.fromMap(respnse.data);
    } on DioError catch (e) {
      return Future.error('Erro ao buscar CEP');
    }
  }
}
