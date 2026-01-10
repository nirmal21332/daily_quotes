import 'dart:convert';

import 'package:daily_quoates/data/app_exception.dart';
import 'package:daily_quoates/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

import 'package:daily_quoates/model/quote_model.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getQuoteData(String url) async {
    var response =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
    var responseBody = _reponseJson(response);
    var data = jsonDecode(responseBody);
    if (data is Map && data.containsKey('quotes')) {
      List<Quote> quotes =
          (data['quotes'] as List).map((e) => Quote.fromJson(e)).toList();
      return quotes;
    }
    return data;
  }

  _reponseJson(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.toString();
      case 400:
        throw FetchDataException('Unauthorized');
      case 401:
        throw FetchDataException('Something went wrong');
      case 403:
        throw FetchDataException('wait');
      case 404:
        throw FetchDataException('Something went wrong');
      case 500:
        throw FetchDataException('Something went wrong');
      default:
        return response;
    }
  }
}
