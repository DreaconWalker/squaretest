import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:squaretest/models/squaremodel.dart';

class Api {
  static const endpoint = 'https://api.github.com/orgs/square/repos';

  var client = http.Client();

  Future<List<SquareApi>> callApplicantApi() async {
    var result = await client.get(
      Uri.parse(endpoint),
    );
    try {
      if (result.statusCode == 200) {
        debugPrint(result.body.toString());
        return squareApiFromJson(result.body.toString());
      } else if (result.statusCode == 404) {
        return [SquareApi(name: 'error')];
      } else {
        throw Exception('failed to load');
      }
    } catch (e) {}
    throw Exception('invalid data parsing');
  }
}
