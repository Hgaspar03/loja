import 'dart:io';

import 'package:dio/dio.dart';

const token = '6b2dbddb3c973d884b61cb99b4f163d9';

class CepAbertoService {
  Future<void> getAdressFromCEP(String cep) async {
    final cleancep = cep.replaceAll('.', '').replaceAll('-', '');

    final endpint = "https://www.cepaberto.com/api/v3/cep?cep=$cleancep";

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final respnse = await dio.get<Map>(endpint);

      if (respnse.data.isEmpty) {
        return Future.error('CEP inválido');
      }
      print(respnse.data);
    } on DioError catch (e) {
      print(e);
      return Future.error('Erro ao buscar CEP');
    }
  }
}
