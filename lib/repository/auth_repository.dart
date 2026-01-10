import 'package:daily_quoates/data/network/base_api_services.dart';
import 'package:daily_quoates/data/network/network_api_services.dart';
import 'package:daily_quoates/resources/app_url.dart';
import 'package:daily_quoates/utils/utils.dart';
import 'package:flutter/widgets.dart';

import 'package:daily_quoates/model/quote_model.dart';

class AuthRepository {
  final BaseApiServices apiServices = NetworkApiServices();

  Future<List<Quote>> loginApi(BuildContext context) async {
    try {
      var response = await apiServices.getQuoteData(AppUrl.baseUrl);
      return response as List<Quote>;
    } catch (e) {
      Utils.showSnackBar(context, e.toString());
      rethrow;
    }
  }
}
