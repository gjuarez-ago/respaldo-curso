import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:invent_app/models/login_response.dart';
import 'package:invent_app/utils/constants.dart';


class AuthService {

  String host = "";

  Future<LoginResponse> login(String user, String password) async {

    var uri = Uri.https(
      host,
      '/api/user/login',
    );


    final http.Response response = await http.post(
      uri,
      headers: Constants.headersPublic,
      body:
          jsonEncode(<String, dynamic>{"username": user, "password": password}),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(json.decode(response.body));
    }

    if (response.statusCode == 400) {
      return throw ("Nombre de usuario / contraseña incorrectos. Inténtalo de nuevo");
    }

    if (response.statusCode == 500) {
      return throw ("Problemas en el servidor");
    }

    return throw ("No funciona el servicio por el momento");
  }

}